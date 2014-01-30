$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "exo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "exo_cms"
  s.version     = Exo::VERSION
  s.authors     = ["Benoit Molenda"]
  s.email       = ["benoit@proxygear.com"]
  s.homepage    = "exo.proxygear.com"
  s.summary     = "A CMS engine."
  s.description = "CMS engine to deliver multiple sites. Based on Mongoid."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '>= 4.0.0'

  #DB
  s.add_dependency 'mongoid' #, '= 4.0.0'
  s.add_dependency 'bson_ext'

  #UI
  s.add_dependency 'foundation-rails', '>5.0.0'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'simple_form'
  s.add_dependency 'gravatar-ultimate'

  #Uploads
  s.add_dependency 'rmagick', '2.13.2'
  s.add_dependency 'fog'
  s.add_dependency 'carrierwave'
  s.add_dependency 'carrierwave-mongoid', '>= 0.6.0' #, require: 'carrierwave/mongoid'

  #Accounts
  s.add_dependency 'devise', '3.0.0.rc'

  #Controllers
  s.add_dependency 'decent_exposure'

  #Assets
  s.add_dependency 'haml-rails'
  s.add_dependency 'sass-rails', '>= 4.0.0'
  s.add_dependency 'uglifier', '>= 1.3.0'
  s.add_dependency 'coffee-rails', '>= 4.0.0'
  s.add_dependency 'jquery-migrate-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency "non-stupid-digest-assets"
  s.add_dependency 'turbolinks'

  #Markdown
  s.add_dependency 'redcarpet'
  s.add_dependency 'albino'
  s.add_dependency 'nokogiri'
  s.add_dependency 'pygments.rb'
  
  #Local uploads
  s.add_development_dependency 'mongoid-grid_fs', '>= 1.9.0' #, github: 'ahoward/mongoid-grid_fs'

  #Testing
  s.add_development_dependency 'its' # allows its(:get_country, :us) syntaxe
  s.add_development_dependency 'dotenv'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'shoulda' # Shoulda
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'factory_girl_rspec'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'ruby-prof' # perf
  s.add_development_dependency 'rspec-rails' #, '> 2.6.0' #
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'mongoid-rspec'
  s.add_development_dependency 'email_spec'
  s.add_development_dependency 'rspec-mocks'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'dotenv'

  s.add_development_dependency 'spork'
  s.add_development_dependency 'guard-spork'

  s.add_development_dependency 'guard-rspec'

  s.add_development_dependency 'debugger'
end
