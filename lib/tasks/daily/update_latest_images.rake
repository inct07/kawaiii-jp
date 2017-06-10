namespace :daily do
  desc '新着画像を更新する'
  task update_latest_images: :environment do
    LatestImages.all_delete
    LatestImages.update
  end
end
