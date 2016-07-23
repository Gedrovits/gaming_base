source 'https://rubygems.org'
ruby '2.3.1'

#= High-level Performance Stuff
gem 'mime-types', '~> 3.1', require: 'mime/types/columnar'
gem 'nokogiri', '~> 1.6'

# gem 'more_optimized_resolver', github: 'amatsuda/more_optimized_resolver' # https://github.com/amatsuda/more_optimized_resolver
gem 'fast_blank'
# gem 'xorcist' # https://github.com/fny/xorcist
# gem 'fast_xs'
# gem 'escape_utils' # https://github.com/brianmario/escape_utils
gem 'oj'
gem 'oj_mimic_json'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

#= Assets Stuff
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'sprockets-es6'
gem 'autoprefixer-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# gem 'hiredis'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'friendly_id' #, '>= 5.1'
# Recurring handling
# gem 'ice_cube'

gem 'premailer-rails'

#= I18n Stuff
gem 'rails-i18n'
gem 'i18n-tasks' # https://github.com/glebm/i18n-tasks
gem 'http_accept_language' # https://github.com/iain/http_accept_language

#= Jobs processing
# gem 'sidekiq'

#= Authentication
gem 'devise'
# gem 'devise_uid'
# gem 'devise_invitable'
gem 'devise-i18n'

#= Authorization / Policies
gem 'pundit'

#= OmniAuth
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'
# FIXME: Until the official oauth2 library will merge this pull request: https://github.com/intridea/oauth2/pull/226
# Pull request is closed...
gem 'oauth2', github: 'matthewrudy/oauth2', branch: 'rack2'
gem 'omniauth-twitch'

#= View Layer Stuff
# gem 'hamlit' # https://github.com/k0kubun/hamlit
gem 'hamlit-rails'

# gem 'haml-rails'
gem 'font-awesome-rails' #, '>= 4.x', '< 5'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'simple_form'
gem 'kaminari'

# source 'https://rails-assets.org' do
#   gem 'rails-assets-semantic'
# end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # FIXME: Review
  gem 'rspec-rails', '>= 3.5.0.beta4'
  gem 'shoulda-matchers', '>= 2.8', '< 3'
  gem 'factory_girl_rails', '>= 4.6'
  # gem 'database_cleaner', '>= 1.5', '< 2'
  gem 'database_rewinder'
  # gem 'capybara'
  # gem 'timecop'
  # gem 'capybara-webkit'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  
  gem 'mailcatcher'

  # Akira Matsuda Tools
  # gem 'traceroute'
  # gem 'nested_scaffold'
  
  # FIXME: Review
  # gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print', require: 'ap' # Usage: ap User.last
  # gem 'derailed_benchmarks', require: false # Memory usage
  # gem 'rack-mini-profiler' # Speed analysis tool
  # gem 'flamegraph' # Flamegraph for RackMiniProfiler add the ?pp=flamegraph
  # gem 'brakeman', require: false
  # gem 'rubocop', require: false
  # gem 'quiet_assets'
  # gem 'memory_profiler'
  # gem 'brakeman' #, '>= 3', '< 4', require: false
  # gem 'annotate' #, '>= 2', '< 3'

  # Deploy
  gem 'mina' # http://mina-deploy.github.io/mina/
  gem 'mina-puma', require: false
  gem 'mina-nginx', require: false
  # gem 'mina-stack', github: 'div/mina-stack'
  # gem 'mina-sidekiq', require: false
end

group :test do
  gem 'simplecov', require: false
  gem 'simplecov-csv', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
