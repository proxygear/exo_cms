require 'exo'
require 'rails'

class Exo
  class Railtie < Rails::Railtie
    railtie_name :exo

    rake_tasks do
      load "tasks/seed.rake"
      load "tasks/generate.rake"
      load "tasks/contributor.rake"
    end
  end
end