require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KawaiiiJp
  class Application < Rails::Application
    config.load_defaults 5.1
    config.time_zone = 'Tokyo'
    config.paths.add 'lib', eager_load: true
  end
end
