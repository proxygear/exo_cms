class Exo
  class Service
    include ::Exo::Document

    embedded_in :site, class_name: 'Exo::Site'

    field :name
    field :path

    validates_presence_of :name
    validates_presence_of :path
  end
end