module ApplicationHelper
  def girl_thumbnail_image(girl)
    girl.thumbnail_image ? girl.thumbnail_image.img_path : '/no_image.png'
  end
end
