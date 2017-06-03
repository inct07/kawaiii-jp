lock '3.8.1'

set :application, 'kawaiii-jp'
set :repo_url, 'https://github.com/inct07/kawaiii-jp.git'
set :branch, 'master'
set :deploy_to, "~/kawaiii-jp"
set :scm, :git

set :format, :pretty
set :log_level, :info
set :keep_releases, 3

set :rbenv_type, :user
set :rbenv_ruby, '2.4.0'

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets}
set :linked_files, %w(.env.production)

