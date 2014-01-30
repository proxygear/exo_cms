class Exo::Resource
  class MetaField
    include Exo::Document

    embedded_in :resource, class_name: 'Exo::Resource', inverse_of: :meta_fields

    field :name,        type: String
    field :slug_id,     type: String
    field :required,    type: Boolean, default: false

    validates_presence_of   :name
    
    def value_class
      if self.class == Exo::Resource::MetaField
        raise "you are using an abstract class"
      end
      raise "value_class should be overrided."
    end
  end
end