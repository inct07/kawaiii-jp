class GoogleCustomSearch
  CUSTOM_SEARCH_URL = 'https://www.googleapis.com/customsearch/v1'
  API_GET_LIMIT = 10
  BULK_GET_COUNT = 10

  def initialize
    @connection = Faraday::Connection.new(url: CUSTOM_SEARCH_URL) do |builder|
      builder.use Faraday::Request::UrlEncoded
      builder.use Faraday::Adapter::NetHttp
    end
  end

  def get_latest_image_paths(girl_name)
    get_image_paths(girl_name, { dateRestrict: 'd1' })
  end

  def bulk_get_image_paths(girl_name)
    paths = []
    BULK_GET_COUNT.times do |i|
      paths << get_image_paths(girl_name, { start: (i * API_GET_LIMIT) + 1 })
    end
    paths.flatten
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
      num: API_GET_LIMIT,
      q: girl_name,
      searchType: 'image',
      imgColorType: 'color',
      imgType: 'face',
    }.merge(options)
  end
end
