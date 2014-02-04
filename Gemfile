source "https://rubygems.org"

# Declare your gem's dependencies in exo_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

ruby '2.0.0'

#gem 'simplecov', require: false, group: :test

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'colorize'
gem 'foundation-rails', '>5.0.0'
gem 'font-awesome-rails'
gem 'sass-rails', '>= 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '>= 4.0.0'
gem 'jquery-migrate-rails'
gem 'jquery-rails'
gem 'devise', '3.0.0.rc'
gem 'gravatar-ultimate'
gem 'haml-rails'
gem 'decent_exposure'
gem 'mongoid'

group :development, :test do
  gem 'carrierwave-mongoid', '>= 0.6.0', require: 'carrierwave/mongoid'
  gem 'mongoid-grid_fs', '>= 1.9.0', github: 'ahoward/mongoid-grid_fs'
end

group :test do
  gem 'its'
  gem 'capybara'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'factory_girl_rspec'
  gem 'factory_girl_rails'
  gem 'factory_girl'
  gem 'faker'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'rspec-mocks'
  gem 'debugger'
  gem 'genspec'
end