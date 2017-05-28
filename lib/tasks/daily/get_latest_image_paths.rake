namespace :daily do
  desc '美少女の最新画像を取得'
  task get_latest_image_paths: :environment do
    Girl.all.each do |girl|
      paths = GoogleCustomSearch.new.get_latest_image_paths(girl.name)
      paths = reject_duplicate_image_paths(girl, paths)
      images = paths.map { |path| Image.new(girl: girl, img_path: path) }
      Image.import images
    end
  end

  private

  def reject_duplicate_image_paths(girl, paths)
    duplicate_images = Image.where(girl: girl, img_path: paths)
    paths.reject do |path|
      duplicate_images.any? {|image| image.img_path == path }
    end
  end
end
