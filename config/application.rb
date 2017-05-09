require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GamingBase
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  
    config.active_record.primary_key = :uuid
    
    config.time_zone = 'UTC'.freeze

    config.i18n.default_locale = :en
    config.i18n.available_locales = Settings.locales
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 } # FIXME

    config.active_job.queue_adapter = :sidekiq

    # Generate only what required
    config.generators do |g|
      g.helper = false
      g.assets = false
      g.test_framework = false # FIXME: Revert when testing is required
    end
  end
end
