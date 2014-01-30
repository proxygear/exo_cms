class Exo
  class Resource::Item
    class AssetValue < AbstractValue
      mount_uploader :content, Exo::ItemAssetUploader

      field :content_type
      field :content_size

      validates_presence_of :content
      validates_integrity_of :content
      
      def value_update value
        self.content = value
      end
    end
  end
end