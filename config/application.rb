require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GamingBase
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  
    config.active_record.primary_key = :uuid
    
    config.time_zone = 'UTC'.freeze

    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # Generate only what required
    config.generators do |g|
      g.helper = false
      g.assets = false
      g.test_framework = false # FIXME: Revert when testing is required
    end
  end
end
