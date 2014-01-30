class Exo::Resource
  class Item
    include Exo::Document

    scope :published, lambda { where(:published_at.lte => DateTime.now, :published_at.ne => nil) }

    field :slug_id
    field :name
    field :published_at, type: DateTime, default: nil
    field :site_slug_id
    field :resource_slug_id
    field :values, type: Hash, default: {}

    before_validation :reset_meta_errors
    before_validation :generate_slug_id
    validates_presence_of :name
    validates_presence_of :slug_id
    validates_presence_of :site_slug_id
    validates_presence_of :resource_slug_id
    validate :meta_field_validation

    #embeds_many :assets, class_name: 'Exo::Resource::ItemAsset'

    #field :_values, type: Hash, default: {}
    embeds_many :values, class_name: 'Exo::Resource::Item::AbstractValue'

    def migrate_values!
      self._values = values
      self.save!
      self[:values] = nil
      self.save!
    end

    def slugify value
      _slug = value.downcase.gsub /([^a-z0-9])+/i, '-'
      _slug = _slug[1..-1] if _slug[0] == '-'
      _slug = _slug[0..-2] if _slug[-1] == '-'
      _slug
    end

    def set_asset field_slug, value
      puts "set asset #{field_slug} #{value}"
      if value == nil
        puts "empty"
        nil
      elsif !value
        puts "remove"
        assets.where(slug_id: field_slug).destroy_all
        nil
      else
        puts "push !"
        asset = assets.where(field_slug_id: field_slug).first || Exo::Resource::ItemAsset.new
        asset.field_slug_id = field_slug unless asset.field_slug_id
        asset.item = self unless asset.item
        asset.content = value
        asset.save
        puts "asset #{asset.inspect}"
        temp_asset[field_slug] = asset
        asset
      end
    end

    def published= boolean
      boolean = boolean == 1 if boolean.kind_of?(Fixnum)
      boolean = boolean == "1" if boolean.kind_of?(String)
      if boolean
        self.published_at = DateTime.now unless published_at
      else
        self.published_at = nil
      end
    end

    def published
      published_at && published_at <= DateTime.now
    end
    
    def scheduled
      published_at && published_at > DateTime.now
    end

    alias :published? :published

    def value_for meta_field
      meta_field = meta_field.slug_id if meta_field.kind_of?(Exo::Resource::MetaField)
      self.values.where(field_slug_id: meta_field.to_s).first
      # if meta_field.kind_of?(Exo::Resource::MetaValue) && meta_field.asset?
      #   v = self.assets.where(field_slug_id: meta_field.slug_id.to_sym).first
      #   v = temp_asset[meta_field.slug_id] unless v
      #   v
      # else
      #   self._values[meta_field.slug_id]
      # end
    end

    def site= site
      self.site_slug_id = site.slug_id
    end

    def site
      Exo::Site.find_by slug_id: site_slug_id
    end

    def temp_asset_for meta_field
      temp_asset[meta_field.slug_id]
    end

    def resource!
      #NOT TESTED
      site.resources.find_by slug_id: self.resource_slug_id
    end

    def resource= r
      self.resource_slug_id = r.slug_id
    end

    def resource
      #NOT TESTED
      site.resources.where(slug_id: self.resource_slug_id).first
    end

    def meta_errors
      @meta_errors ||= Exo::Resource::MetaErrors.new
    end

    protected
    def generate_slug_id
      self.slug_id = slugify self.name
    end

    def reset_meta_errors
      @meta_errors = Exo::Resource::MetaErrors.new
    end

    def temp_asset
      @temp_asset ||= HashWithIndifferentAccess.new
    end

    def meta_field_validation
      reset_meta_errors
      resource.meta_fields.each do |meta_field|
        _value = value_for meta_field
        raise "'#{meta_field.slug_id}' value missing" if !_value
        _value.meta_field_validation meta_field
      end

      #   if f.kind_of?(Exo::Resource::MetaValue) && !f.asset?
      #     self._values[f.slug_id] = nil if self._values[f.slug_id].blank?
      #     self._values[f.slug_id] = f.default if !self._values[f.slug_id] && f.default
      #   end
      # 
      #   value = value_for f
      #   puts "value for #{f.slug_id} -> #{!!value}"
      #   meta_errors.add f.slug_id, :required if !value && f.required
      # 
      #   if f.kind_of?(Exo::Resource::MetaValue) && f.unique
      #     sibling = resource!.items.where("values.#{f.slug_id}" => value).first
      #     if sibling && sibling != self
      #       meta_errors.add f.slug_id, :already_taken
      #     end
      #   end
      # 
      #   #FIXME format validation
      # end
      # unless meta_errors.empty?
      #   errors.add :_values, :errors
      # end
    end
  end
end