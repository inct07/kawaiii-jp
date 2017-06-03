class Scraping
  IMG_SEARCH_URL = 'https://www.google.co.jp/search?source=lnms&tbm=isch&sa=X&ved=0ahUKEwjZlJad3trTAhVMGpQKHa-ZCAYQ_AUICigB&biw=1280&bih=680#tbas=0&tbm=isch&q='
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.63 Safari/537.36'

  def initialize
  end

  def get_image_paths(girl_name)
    param = '&tbs=isz:lt,islt:qsvga,itp:face,ic:color'
    url = IMG_SEARCH_URL + girl_name + param
    url_escape = URI.escape(url)
    charset = nil
    html = open(url_escape, 'User-Agent' => USER_AGENT) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.xpath('//div[@class="rg_meta"]').map do |node|
      JSON.parse(node.text)['ou']
    end
  end
end