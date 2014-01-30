class Exo
  class Resource::ItemAsset
    include Exo::Document

    embedded_in :item, class_name: 'Exo::Resource::Item'

    mount_uploader :content, Exo::ItemAssetUploader

    field :field_slug_id
    field :content_type
    field :content_size

    validates_presence_of :content
    validates_integrity_of :content
    
    def site
      item ? item.site : nil
    end
  end
end