class Exo::Resource
  class MetaRelation < MetaField
    field :resource_slug_id
    field :many,        type: Boolean, default: false

    validates_presence_of   :resource_slug_id

    before_validation :genarate_slug_id, on: :create, if: :name

    protected
    def clean_default
      self.default = nil if self.default.blank?
    end

    def genarate_slug_id
      if !self.slug_id
        if many
          self.slug_id = "#{self.name.to_s.underscore}_ids" #fixme
        else
          self.slug_id = "#{self.name.to_s.underscore}_ids"
        end
      end
    end
  end
end