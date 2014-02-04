gem 'exo_cms'

# Exo local upload on Mongoid
group([:development, :test]) do
  gem 'bson_ext'
  gem 'carrierwave-mongoid', '>= 0.6.0', require: 'carrierwave/mongoid'
  gem 'mongoid-grid_fs', '>= 1.9.0', github: 'ahoward/mongoid-grid_fs'
end