module Exo::UploadVersions
  extend ActiveSupport::Concern

  VERSIONS = {
    xlarge: 1921,
    large: 1441,
    medium: 1025,
    small: 640,
    thumb: 320
  }

  RATION_WH = 0.3
  FAKEIMG_COLOR = '/dddddd/333333'

  included do
    VERSIONS.each do |version_name, width|
      parent_version_index = VERSIONS.keys.index(version_name) - 1
      parent_version_name = VERSIONS.keys[parent_version_index] if parent_version_index >= 0
      
      if parent_version_name
        version version_name, from_version: parent_version_name do
          puts "resize -> #{version_name} from #{parent_version_name}"
          process resize_to_limit: [width, nil]
        end
      else
        version version_name do
          puts "resize -> #{version_name} from ORIGINAL"
          process resize_to_limit: [width, nil]
        end
      end
    end
  end
  
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    fake_image_for version_name
  end
  
  protected
  def fake_image_for name
    _version_name = version_name || :xlarge
    _width = VERSIONS[_version_name.to_sym] || VERSIONS[:xlarge]
    "http://fakeimg.pl/#{_width}x#{(_width * RATION_WH).to_i}#{FAKEIMG_COLOR}"
  end
  
  def resize_to_width(width, height)
    puts "resize_to_width #{width}/#{height}"
    manipulate! do |img|
      puts "img.columns #{img.columns} >= #{width}"
      if img.columns >= width
        img.resize! width #"#{width}x#{img[:height]}"
      end
      img = yield(img) if block_given?
      img
    end
  end
end