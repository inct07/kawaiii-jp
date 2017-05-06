namespace :image do

  CUSTOM_SEARCH_URL = 'https://www.googleapis.com'
  IMG_SEARCH_URL = 'https://www.google.co.jp/search?source=lnms&tbm=isch&sa=X&ved=0ahUKEwjZlJad3trTAhVMGpQKHa-ZCAYQ_AUICigB&biw=1280&bih=680#tbas=0&tbm=isch&q='
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.63 Safari/537.36'

  desc 'Google画像検索結果から美少女画像のデータを追加'
  task get_images_by_scraping: :environment do
    get_images(false)
  end

  desc 'GoogleCustomSerarchAPIから美少女画像のデータを追加'
  task get_images_by_api: :environment do
    get_images(true)
  end

  private
  def get_images(use_api)
    Girl.all.each do |girl|
      girl_id = girl.id
      query = girl.name
      url_list = use_api ? get_url_by_api(query) : get_url_by_scraping(query)

      images = []
      url_list.each do |url|
        duplicate_img = Image.where(girl: girl, img_path: url)
        if duplicate_img.blank?
          images << Image.new(
            :girl_id => girl_id,
            :img_path => url
          )
        end
      end
      Image.import images
    end
  end

  def get_url_by_scraping(query)
    param = '&tbs=isz:lt,islt:qsvga,itp:face,ic:color'
    url = IMG_SEARCH_URL + query + param
    url_escape = URI.escape(url)
    charset = nil
    html = open(url_escape, "User-Agent" => USER_AGENT) do |f|
      charset = f.charset
      f.read
    end

    url_list = []
    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.xpath('//div[@class="rg_meta"]').each do |node|
      url_list << JSON.parse(node.text)["ou"]
    end
    return url_list
  end

  def get_url_by_api(query, total_num = 10)
    conn = Faraday::Connection.new(:url => CUSTOM_SEARCH_URL) do |builder|
        builder.use Faraday::Request::UrlEncoded
        # builder.use Faraday::Response::Logger
        builder.use Faraday::Adapter::NetHttp
    end

    i = 0
    url_list = []
    while i < total_num do
      response = conn.get do |req|
        req.url '/customsearch/v1'
        req.params[:key]            = ENV['GOOGLE_DEVELOPERS_API_KEY']
        req.params[:cx]             = ENV['CUSTOM_SEARCH_ENGINE_ID']
        req.params[:num]            = total_num - i > 10 ? 10 : total_num - i
        req.params[:start]          = i + 1
        req.params[:q]              = query
        req.params[:searchType]     = 'image'
        req.headers['Content-Type'] = 'application/json'
      end

      JSON.parse(response.body)['items'].each do |item|
        url_list << item['link']
      end

      i = i + 10
    end
    return url_list
  end

end
