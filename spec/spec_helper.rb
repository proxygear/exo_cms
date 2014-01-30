require 'rubygems'
require 'its'
require 'colorize'
puts "spec helper".colorize(:green)

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
spec_root = File.expand_path('..', __FILE__)

require 'rspec/rails'
require 'capybara/dsl'
require 'database_cleaner'
require 'mongoid-rspec'
require 'shoulda-matchers'
require 'factory_girl_rspec'
require 'email_spec'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

Mongoid.logger.level = Logger::WARN
Capybara.default_selector = :css

RSpec.configure do |config|
  config.include RSpec::Rails::RequestExampleGroup, :example_group => {
    :file_path => config.escaped_path(%w(spec (end_points)))
  }
  
  [
    FactoryGirl::Syntax::Methods,
    ::Mongoid::Matchers,
    Capybara::DSL,
    ContributorSupport,
  ].each do |mod|
    puts "include #{mod}".colorize(:green)
    config.include mod
  end

  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner.start
  end

  config.after(:each) do
    Warden.test_reset! if Warden.respond_to?(:test_reset!)
    DatabaseCleaner.clean
  end

  config.mock_with :rspec
end