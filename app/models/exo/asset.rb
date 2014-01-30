class Exo
  class Asset
    include Exo::Document

    field :site_slug_id
    field :name

    mount_uploader :content, Exo::AssetUploader

    field :content_type
    field :content_size

    validates_presence_of :content
    validates_integrity_of :content
    validates_presence_of :site_slug_id

    before_save :default_name

    def site
      Exo::Site.find_by slug_id: site_slug_id
    end
    
    def site= site
      self.site_slug_id = site.slug_id
    end
    
    protected
    def default_name
      name = content.url.to_s.split('.').last if content && !name
    end
  end
end