namespace :exo do
  desc "Generate site folder and config file"
  task :generate, [:slug] => :environment do |t, args|
    g = Exo::Generator.new args[:slug]
    g.generates_config
    g.generates_folders
  end
end