class Exo::Resource
  class MetaValue < MetaField
    DATUM_TYPES = [
      :string,
      :text,
      :image,
      :file,
      :datetime,
      :time,
      :belongs_to,
      :has_many,
      :markdown,
      :list
    ]

    DEFAULT_VALUE_CLASS = Exo::Resource::Item::SimpleValue
    VALUE_CLASSES = {
      belongs_to: Exo::Resource::Item::BelongsToValue,
      has_many:   Exo::Resource::Item::HasManyValue,
      markdown:   Exo::Resource::Item::MarkdownValue,
      list:       Exo::Resource::Item::ListValue,

      image:      Exo::Resource::Item::AssetValue,
      file:      Exo::Resource::Item::AssetValue
    }

    field :datum_type,  type: String
    field :default,     type: String
    field :unique,      type: Boolean, default: false

    before_validation :clean_default

    validates_presence_of   :name
    validates_inclusion_of  :datum_type, in: DATUM_TYPES.collect {|t| t.to_s}

    before_validation :genarate_slug_id, on: :create, if: :name
    #FIXME validate uniqueness of name

    def value_class
      VALUE_CLASSES[datum_sym] || DEFAULT_VALUE_CLASS
    end

    def datum_sym
      datum_type.to_sym if datum_type
    end

    def asset?
      ['image'].include? datum_type.to_s
    end

    protected
    def clean_default
      self.default = nil if self.default.blank?
    end

    def genarate_slug_id
      self.slug_id = self.name #fixme
    end
  end
end