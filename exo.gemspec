$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "exo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "exo_cms"
  s.version     = Exo::VERSION
  s.authors     = ["Benoit Molenda"]
  s.email       = ["benoit@proxygear.com"]
  s.homepage    = "https://github.com/proxygear/exo_cms"
  s.summary     = "A CMS engine."
  s.description = "CMS engine to deliver multiple sites. Based on Mongoid."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '~> 4.0'

  #DB
  s.add_runtime_dependency 'mongoid', '>= 4.0.0.alpha1', '< 5.0.0'
  s.add_dependency 'draper', '~> 1.2'

  #UI
  s.add_dependency 'foundation-rails', '~> 5.0'
  s.add_dependency 'font-awesome-rails', '~> 4.0'
  s.add_dependency 'simple_form', '~> 3.0'
  s.add_dependency 'gravatar-ultimate', '~> 2.0'

  #Uploads
  s.add_dependency 'rmagick', '~> 2.13'
  s.add_dependency 'fog', '~> 1.19'
  s.add_dependency 'carrierwave', '~> 0.9'
  
  #Accounts
  s.add_runtime_dependency 'devise', ['>= 3.0.0.rc', '< 4.0.0']

  #Controllers
  s.add_dependency 'decent_exposure', '~> 2.0'

  #Assets
  s.add_dependency 'haml-rails', '~> 0.5'
  s.add_dependency 'sass-rails', '~> 4.0'
  s.add_dependency 'uglifier', '~> 2.4'
  s.add_dependency 'coffee-rails', '~> 4.0'
  s.add_dependency 'jquery-migrate-rails', '~> 1.2'
  s.add_dependency 'jquery-rails', '~> 3.0'
  s.add_dependency "non-stupid-digest-assets", '~> 1.0'

  #Markdown
  s.add_dependency 'redcarpet', '~> 3.0'
  s.add_dependency 'albino', '~> 1.3'
  s.add_dependency 'nokogiri', '~> 1.6'
  s.add_dependency 'pygments.rb', '~> 0.5'
  
  #Misc
  s.add_dependency 'colorize'
end
