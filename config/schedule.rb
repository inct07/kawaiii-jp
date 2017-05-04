set :output, "/tmp/cron.log"

every 1.minute do
  command "echo 'hoge' >> /tmp/hoge.txt"
end
