source 'https://rubygems.org'
ruby '2.7.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#= High-level Performance Stuff
gem 'mime-types' #, '~> 3.1', require: 'mime/types/columnar'
gem 'nokogiri' #, '~> 1.x', '< 2'

# gem 'more_optimized_resolver', github: 'amatsuda/more_optimized_resolver' # https://github.com/amatsuda/more_optimized_resolver
gem 'fast_blank' #, '~> 1.x', '< 2'
# gem 'xorcist' # https://github.com/fny/xorcist
# gem 'fast_xs'
# gem 'escape_utils' # https://github.com/brianmario/escape_utils
gem 'oj' #, '~> 3.x'
gem 'oj_mimic_json' #, '~> 1.x', '< 2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.0.3' #, '>= 5.1', '< 6'

# Additional Caching
# gem 'actionpack-page_caching' # caches_page in controller
# gem 'actionpack-action_caching' # caches_action in controller

# Use postgresql as the database for Active Record
gem 'pg' #, '~> 0.20'
# Use Puma as the app server
gem 'puma' #, '~> 3.x', '< 4'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks' #, '~> 5.x', '< 6'

gem 'json' #, '~> 2.0'

gem 'config' #, '~> 1.x' # Access to Settings object

gem 'paranoia' #, '~> 2.x', '< 3'

#= Abstraction
gem 'draper' #, '~> 3.x', '< 4'

# Error Tracking
gem 'sentry-raven' #, '~> 2.x', '< 3'

#= Assets Stuff
# Use SCSS for stylesheets
gem 'sass-rails' #, '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier' #, '~> 3.x', '< 4'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails' #, '~> 4.x', '< 5'
gem 'sprockets-es6'
gem 'autoprefixer-rails' #, '~> 7.x'

# Use Redis adapter to run Action Cable in production
gem 'redis' #, '~> 3.x', '< 4'
# gem 'hiredis'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'friendly_id' #, '~> 5.x', '< 6'
# Recurring handling
# gem 'ice_cube'

gem 'premailer-rails'

#= I18n Stuff
gem 'rails-i18n' #, '~> 5.0.0'
gem 'devise-i18n' #, '~> 1.x'
gem 'i18n-tasks' #, '< 2', require: false # https://github.com/glebm/i18n-tasks

gem 'http_accept_language' #, '~> 2.x', '< 3' # https://github.com/iain/http_accept_language

gem 'i18n-js' #, '~> 3.x', '< 4'

#= Jobs processing
gem 'sidekiq' #, '~> 5.x', '< 6'

#= Monitoring
gem 'librato-rails'

#= Authentication
gem 'devise' #, github: 'plataformatec/devise', branch: 'master' # FIXME: Replace when it will be on RubyGems
# gem 'devise_uid'
# gem 'devise_invitable'

#= Authorization / Policies
gem 'pundit'

#= OmniAuth
gem 'oauth2'
gem 'omniauth-facebook' #, '~> 4.x', '< 5'
gem 'omniauth-twitter' #, '~> 1.x', '< 2'
gem 'omniauth-google-oauth2' #, '~> 0.x', '< 2'
gem 'omniauth-github' #, '~> 1.x', '< 2'
gem 'omniauth-twitch' #, '~> 0.x', '< 2'
gem 'omniauth-steam' #, '~> 1.x', '< 2'

#= View Layer Stuff
gem 'browser' #, '~> 2.x'
gem 'cocoon' # Dynamic nested forms

# gem 'hamlit', '~> 2.x', '< 3' # https://github.com/k0kubun/hamlit
gem 'hamlit-rails'
# gem 'haml-rails'

# gem 'gon'
# gem 'ejs'

gem 'simple_form' #, github: 'christiannelson/simple_form', branch: 'rails-5.1' # FIXME: Deprecate usage of it
gem 'kaminari' #, '~> 1.x'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'parallel_tests' #, '~> 2.x', '< 3'
  
  gem 'rspec-rails' #, '~> 3.x', '< 4'
  gem 'shoulda-matchers' #, '~> 3.x'
  gem 'factory_girl_rails' #, '~> 4.x', '< 5'
  # gem 'database_cleaner', '>= 1.5', '< 2'
  gem 'database_rewinder' #, '< 2'
  # gem 'capybara'
  # gem 'timecop'
  # gem 'capybara-webkit'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen' #, '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring' #, '~> 2.x'
  gem 'spring-watcher-listen' #, '~> 2.0.0'
  
  gem 'letter_opener' #, '~> 1.4'

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
  # gem 'mina' # http://mina-deploy.github.io/mina/
  # gem 'mina-puma', require: false
  # gem 'mina-nginx', require: false
  # gem 'mina-stack', github: 'div/mina-stack'
  # gem 'mina-sidekiq', require: false

  gem 'bundleup' #, '~> 0.x'
end

group :test do
  gem 'simplecov', require: false
  gem 'simplecov-csv', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
