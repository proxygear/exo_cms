#Quick Mongoid 4.X install

We are going for a pure mongoid DB setup.
If you want more details and/or keep active_record running at the same time,
please check the (mongoid documentation)[http://mongoid.org]
 
Add to your gem file

    #I'm living on the edge... 4.0.0.alpha2
    gem 'mongoid', git: 'https://github.com/mongoid/mongoid.git'
    gem 'bson_ext', , '~> 1.5'

In your application.rb, you have to comment the require 'rails/all' and require components as following.

    #require 'rails/all'
    require "action_controller/railtie"
    require "action_mailer/railtie"
    #require "active_resource/railtie"
    require "rails/test_unit/railtie"

Check your environement files (environment.rb, development.rb, ...) and comment all the line starting with `config.active_record`. 