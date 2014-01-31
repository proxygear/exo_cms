class Exo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      #namespace 'exo'

      desc "This generator add exo gem to your Gemfile, mount the engine and add an initializer"
      def install
        append_file 'Gemfile', "\ngem 'exo_cms'"

        template "initializer.rb", "config/initializers/exo.rb"

        File.open(File.join(self.class.source_root, 'engine_routes.rb'), 'r') do |f|
          route f.read
        end
      end
    end
  end
end