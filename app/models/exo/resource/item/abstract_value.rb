class Exo
  class Resource::Item::AbstractValue
    include Exo::Document

    embedded_in :item, class_name: 'Exo::Resource::Item'

    field :field_slug_id

    validates_presence_of :field_slug_id
    validate :field_existance

    def site
      item ? item.site : nil
    end

    def value_update params
      raise "value_update should be overrided in #{self.class}"
    end

    def meta_field_validation meta_field
      
    end

    def form_value
      raise "form_value should be overrided in #{self.class}"
    end

    protected
    def field_existance
      unless item.resource.meta_field_for self.field_slug_id
        errors.add :field_slug_id, :invalid
      end
    end
  end
end