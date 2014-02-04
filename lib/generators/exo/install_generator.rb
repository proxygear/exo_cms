class Exo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "This generator add exo gem to your Gemfile, mount the engine and add an initializer"
      def install
        File.open(File.join(self.class.source_root, 'gems.rb'), 'r') do |f|
          append_file 'Gemfile', f.read
        end

        template "initializer.rb", "config/initializers/exo.rb"

        #Bundler.require(:default, Rails.env) application.rb require 'exo'
        File.open(File.join(self.class.source_root, 'engine_routes.rb'), 'r') do |f|
          route f.read
        end
      end
    end
  end
end