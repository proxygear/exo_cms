class Exo
  class Setting
    include Exo::Document

    embedded_in :setting_container, polymorphic: true

    field :slug_id
    field :name
    field :value
    field :required, type: Boolean, default: false
    field :system, type: Boolean, default: false

    validates_presence_of :slug_id
    validates_presence_of :name
    validates_presence_of :value, if: :required
    validate :slug_id_uniquness, if: :setting_container

    def name
      self[:name] || self.slug_id
    end

    protected
    def slug_id_uniquness
      setting_container.settings.each do |s|
        next if s == self || s.slug_id.to_s != self.slug_id
        errors.add :slug_id, :already_taken
        break
      end
    end
  end
end