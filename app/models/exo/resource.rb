class Exo
  class Resource
    include Exo::Document

    embedded_in :site, class_name: 'Exo::Site'
    embeds_many :meta_fields, class_name: 'Exo::Resource::MetaField', inverse_of: :resource

    field :name
    field :slug_id

    validates_presence_of :name
    validates_uniqueness_of :name
    validates_presence_of :slug_id
    validates_uniqueness_of :slug_id

    before_validation :generate_slug_id, on: :create, if: :name

    def meta_field_for key
      meta_fields.where(slug_id: key).first
    end

    def items
      site.slug_scope(Exo::Resource::Item).where resource_slug_id: self.slug_id
    end

    protected
    def generate_slug_id
      self.slug_id = self.name #fixme
    end

    # def slug_uniqueness
    #   site.routes.each do |r|
    #     if r.path == self.path && (self.new_record? || r.id != self.id)
    #       errors.add :path, :already_taken
    #       break
    #     end
    #   end
    # end
  end
end
