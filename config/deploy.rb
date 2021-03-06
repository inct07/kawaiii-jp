lock '3.8.1'

set :application, 'kawaiii-jp'
set :repo_url, 'https://github.com/inct07/kawaiii-jp.git'
set :branch, 'master'
set :deploy_to, '~/kawaiii-jp'
set :scm, :git

set :format, :pretty
set :log_level, :info
set :keep_releases, 3

set :rbenv_type, :user
set :rbenv_ruby, '2.4.0'

set :linked_dirs, %w{bin bundle log public tmp}
set :linked_files, %w(.env.production)

set :whenever_environment, 'production'
set :whenever_roles, :batch

after 'deploy:updated', 'deploy:migrate'
after 'deploy:publishing', 'deploy:restart'
after 'deploy:finishing', 'deploy:notifier'

namespace :deploy do
  desc 'database migrate'
  task :migrate do
    on roles(:app) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :rake, 'db:migrate'
        end
      end
    end
  end

  desc 'unicorn restart'
  task :restart do
    on roles(:app) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :rake, 'unicorn:stop'
          execute :rake, 'unicorn:start'
        end
      end
    end
  end

  desc 'slack notifier'
  task :notifier do
    on roles(:app) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :rake, 'tools:slack_notifier:deploy'
        end
      end
    end
  end
end

