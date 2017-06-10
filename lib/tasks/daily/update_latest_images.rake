namespace :daily do
  desc '新着画像を更新する'
  task update_latest_images: :environment do
    LatestImage.all.each { |latest_image| latest_image.destroy }
    today_period = Time.current.beginning_of_day..Time.current.end_of_day
    latest_images = Image.where(created_at: today_period).shuffle
    latest_images.each do |latest_image|
      LatestImage.create(image_id: latest_image.id, girl_id: latest_image.girl_id, img_path: latest_image.img_path)
    end
  end
end
