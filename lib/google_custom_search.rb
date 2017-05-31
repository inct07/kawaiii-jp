class GoogleCustomSearch
  CUSTOM_SEARCH_URL = 'https://www.googleapis.com/customsearch/v1'
  GET_LIMIT = 10
  BULK_GET_COUNT = 10
  REQUEST_LIMIT_PER_DAY = 100
  REQUEST_LIMIT_RESET_HOUR = 17

  class RequestLimit < StandardError; end

  def initialize
    @connection = Faraday::Connection.new(url: CUSTOM_SEARCH_URL) do |builder|
      builder.use Faraday::Request::UrlEncoded
      builder.use Faraday::Adapter::NetHttp
    end
  end

  def get_latest_image_paths(girl_name)
    if today_request_count < REQUEST_LIMIT_PER_DAY
      image_paths = get_image_paths(girl_name, { dateRestrict: 'd1' })
      GoogleCustomSearchHistory.create(request_by: GoogleCustomSearchHistory.request_bies[:latest])
    else
      raise RequestLimit
    end
    image_paths
  end

  def bulk_get_image_paths(girl_name)
    if today_request_count + BULK_GET_COUNT < REQUEST_LIMIT_PER_DAY
      paths = []
      BULK_GET_COUNT.times do |i|
        paths << get_image_paths(girl_name, { start: (i * GET_LIMIT) + 1 })
        GoogleCustomSearchHistory.create(request_by: GoogleCustomSearchHistory.request_bies[:bulk])
      end
      paths.flatten
    else
      raise RequestLimit
    end
  end

  private

  def get_image_paths(girl_name, options = {})
    response = @connection.get do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params = param_generator(girl_name, options)
    end

    items = JSON.parse(response.body)['items']
    items.flat_map { |item| item['link'] }
  end

  def param_generator(girl_name, options = {})
    {
      key: ENV['GOOGLE_DEVELOPERS_API_KEY'],
      cx: ENV['CUSTOM_SEARCH_ENGINE_ID'],
      num: GET_LIMIT,
      q: girl_name,
      searchType: 'image',
      imgColorType: 'color',
      imgType: 'face',
    }.merge(options)
  end

  def today_request_count
    prev_date =
      if Time.current.hour >= REQUEST_LIMIT_RESET_HOUR
        Time.current.strftime('%Y-%m-%d')
      else
        Time.current.yesterday.strftime('%Y-%m-%d')
      end
    prev_date_time = Time.zone.parse("#{prev_date} #{REQUEST_LIMIT_RESET_HOUR}:00:00")
    GoogleCustomSearchHistory.where(created_at: prev_date_time..Time.current).count
  end
end
