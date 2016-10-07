Raven.configure do |config|
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.dsn = 'https://5d2c720f05864baa9f19a8cc46d54766:e1c5c0d861634b0bbd5572c39eb5142c@sentry.io/104534'
  config.environments = ['production']
end
