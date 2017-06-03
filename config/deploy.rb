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

set :linked_dirs, %w{bin bundle log public tmp}
set :linked_files, %w(.env.production)

after 'deploy:updated', 'deploy:migrate'
after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'database migrate'
  task :migrate do
    on roles(:app) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :rake, "db:migrate"
        end
      end
    end
  end

  desc 'unicorn restart'
  task :restart do
    on roles(:app) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :rake, "unicorn:stop"
          execute :rake, "unicorn:start"
        end
      end
    end
  end
end

