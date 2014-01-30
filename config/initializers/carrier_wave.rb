require 'carrierwave/mongoid'

CarrierWave.configure do |config|
  if ['development', 'test'].include?(Rails.env)
    puts "CarrierWave local on grid fs (dev/test)"

    # config.fog_credentials = {
    #   provider:     'local',
    #   local_root:   "#{Rails.root}/tmp/storage",
    #   endpoint:     Rails.root.join('tmp')
    # }

    config.storage :grid_fs
    config.grid_fs_access_url = "/grid_fs"
    config.root = Rails.root.join('tmp')
    #puts "root #{Rails.root.join('tmp')}"
    config.cache_dir = "uploads" 
  else
    puts "CarrierWave prod on amazone (#{Rails.env})"

    config.storage :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY'],
      region:                'eu-west-1'
    }

    config.fog_directory  = 'exo1'
    #config.asset_host     = 'https://s3.amazonaws.com'
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
    config.cache_dir = "#{Rails.root}/tmp/carrierwave" 
  end
end