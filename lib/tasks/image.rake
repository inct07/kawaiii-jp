namespace :image do

  CUSTOM_SEARCH_URL = 'https://www.googleapis.com'
  IMG_SEARCH_URL = 'https://www.google.co.jp/search?source=lnms&tbm=isch&sa=X&ved=0ahUKEwjZlJad3trTAhVMGpQKHa-ZCAYQ_AUICigB&biw=1280&bih=680#tbas=0&tbm=isch&q='
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.63 Safari/537.36'
  API_GET_LIMIT = 10

  desc 'Google画像検索結果から美少女画像のデータを追加'
  task get_image_paths_by_scraping: :environment do
    get_image_paths do |query|
      get_url_by_scraping(query)
    end
  end

  desc 'GoogleCustomSerarchAPIから美少女画像のデータを追加'
  task get_image_paths_by_api: :environment do
    get_image_paths do |query|
      get_url_by_api(query)
    end
  end

  private

  def get_image_paths
    Girl.all.each do |girl|
      urls = yield(girl.name)
      duplicate_images = Image.where(girl: girl, img_path: urls)
      images = []
      urls.each do |url|
        images << Image.new(girl: girl, img_path: url) unless duplicate_images.any?{ |image| image.img_path == url }
      end
      Image.import images
    end
  end

  def get_url_by_scraping(query)
    param = '&tbs=isz:lt,islt:qsvga,itp:face,ic:color'
    url = IMG_SEARCH_URL + query + param
    url_escape = URI.escape(url)
    charset = nil
    html = open(url_escape, 'User-Agent' => USER_AGENT) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    urls =
      doc.xpath('//div[@class="rg_meta"]').map do |node|
        JSON.parse(node.text)['ou']
      end
  end

  def get_url_by_api(query, total_num = 10)
    conn = Faraday::Connection.new(url: CUSTOM_SEARCH_URL) do |builder|
       builder.use Faraday::Request::UrlEncoded
       # builder.use Faraday::Response::Logger
       builder.use Faraday::Adapter::NetHttp
    end

    i = 0
    urls = []
    while i < total_num do
      response = conn.get do |req|
        req.url '/customsearch/v1'
        req.params[:key]            = ENV['GOOGLE_DEVELOPERS_API_KEY']
        req.params[:cx]             = ENV['CUSTOM_SEARCH_ENGINE_ID']
        req.params[:num]            = total_num - i > API_GET_LIMIT ? API_GET_LIMIT : total_num - i
        req.params[:start]          = i + 1
        req.params[:q]              = query
        req.params[:searchType]     = 'image'
        req.headers['Content-Type'] = 'application/json'
      end

      JSON.parse(response.body)['items'].each do |item|
        urls << item['link']
      end
      i = i + API_GET_LIMIT
    end
    urls
  end
end
