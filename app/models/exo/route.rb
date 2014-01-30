class Exo
  class Route
    include Exo::Document

    embedded_in :site,      class_name: 'Exo::Site'
    embeds_many :settings,  class_name: 'Exo::Setting', as: :setting_container

    field :slug_id
    field :path

    validates_presence_of :slug_id
    validates_format_of :path, with: ::Exo::Regexp::ROUTING_PATH
    #validates_uniqueness_of :path
    validate :path_uniqueness, if: :site

    def redirection?
      self.class == Exo::Route::Redirection
    end

    def url
      site.url + self.path
    end

    def redirection?
      self.class == Exo::Route::Redirection
    end
    
    protected
    def path_uniqueness
      site.routes.each do |r|
        if (r.path == self.path) && (self != r)
          errors.add :path, :already_taken
          break
        end
      end
    end
  end
end