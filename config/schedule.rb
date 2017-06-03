set :output, "/tmp/cron.log"

every 1.day, at: '16:30' do
  rake 'daily:get_latest_image_paths'
end
