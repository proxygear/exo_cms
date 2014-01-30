# encoding: utf-8
require 'carrierwave/mongoid'

class Exo::ItemAssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::RMagick

  if ['development', 'test'].include?(Rails.env)
    storage :grid_fs
  else
    storage :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{site_path}/#{model_path}"
  end

  def site_path
    "exo/#{model.site.slug_id}"
  end

  def model_path
    i = model.item
    "resources/#{i.resource.slug_id}/#{i.slug_id}/#{model.field_slug_id}"
  end

  process :set_content_type

  process :save_content_type_and_size_in_model

  def save_content_type_and_size_in_model
    model.content_type = file.content_type if file.content_type
    model.content_size = file.size
  end

  include Exo::UploadVersions

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
