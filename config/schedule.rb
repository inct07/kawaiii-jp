set :output, "/tmp/cron.log"

every 1.day, at: '16:30' do
  rake 'daily:get_latest_image_paths'
end

every 1.day, at: '17:00' do
  rake 'daily:update_latest_images'
end
