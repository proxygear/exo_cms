namespace :exo do
  desc "Seed targeted theme"
  task :seed, [:slug] => :environment do |t, args|
    require 'exo/config'
    Exo::Config.new(args[:slug], args).install!
  end
end