namespace :development do
  desc 'Google画像検索結果をスクレピングして美少女画像のデータを追加'
  task :get_image_paths, ['girl_id'] => :environment do |task, args|
    girl = Girl.find_by(id: args.girl_id)
    if girl.blank?
      puts '該当の美少女が見つかりません'
      next
    end

    paths = Scraping.new.get_image_paths(girl.name)
    paths = reject_duplicate_image_paths(girl, paths)
    images = paths.map { |path| Image.new(girl: girl, img_path: path) }
    Image.import images
  end

  private

  def reject_duplicate_image_paths(girl, paths)
    duplicate_images = Image.where(girl: girl, img_path: paths)
    paths.reject do |path|
      duplicate_images.any? {|image| image.img_path == path }
    end
  end
end
