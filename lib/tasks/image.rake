namespace :image do

  IMG_SEARCH_URL = 'https://www.google.co.jp/search?source=lnms&tbm=isch&sa=X&ved=0ahUKEwjZlJad3trTAhVMGpQKHa-ZCAYQ_AUICigB&biw=1280&bih=680#tbas=0&tbs=isz:lt,islt:qsvga,itp:photo,ic:color&tbm=isch&q='
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.63 Safari/537.36'

  desc '美少女画像のデータ追加タスク'
  task get_images: :environment do
    Girl.all.each do |girl|
      girl_id = girl.id
      query = girl.name
      url_list = get_url_list(query)

      images = []
      url_list.each do |url|
        duplicate_img = Image.where(girl: girl, img_path: url)
        if duplicate_img.blank?
          images << Image.new(
            :girl_id => girl_id,
            :img_path => url,
          )
        end
      end
      Image.import images
    end
  end

  private
  def get_url_list(query)
    url = IMG_SEARCH_URL + query
    url_escape = URI.escape(url)
    user_agent = USER_AGENT
    charset = nil
    html = open(url_escape, "User-Agent" => user_agent) do |f|
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

end
