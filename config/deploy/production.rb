set :stage, :production
set :rails_env, 'production'
server ENV['PRODUCTION_HOST'],
       user: ENV['PRODUCTION_USER'],
       roles: %w{web app batch}

set :ssh_options, {
  keys: ENV['PRODUCTION_SSH_KEY']
}
