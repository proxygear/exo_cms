class Exo
  class Site
    include ::Exo::Document

    field :slug_id
    field :theme_path

    field :main_host
    field :hosts, type: Array, default: []

    embeds_many :settings,  class_name: 'Exo::Setting', as: :setting_container
    embeds_many :routes,    class_name: 'Exo::Route'
    embeds_many :resources, class_name: 'Exo::Resource'
    embeds_many :services,  class_name: 'Exo::Service'

    has_and_belongs_to_many :contributors, class_name: 'Exo::Contributor', inverse_of: :sites

    validate :hosting_validation
    validates_presence_of :slug_id
    validates_uniqueness_of :slug_id
    validates_format_of :theme_path, with: Exo::Regexp::REL_PATH

    def name
      unless (array = main_host.split('.')[0..-2]).empty?
        array.join(' ')
      else
        main_host
      end
    end

    def slug_scope scope
      scope.where site_slug_id: self.slug_id
    end

    def url path=nil
      "http://#{main_host}#{path}"
    end

    def nest_path path
      File.join theme_path, path.to_s
    end
    
    def resource_name name
      resources.find_by slug_id: name.to_s
    end

    protected
    def hosting_validation
      hosts.each do |host|
        unless host =~ Exo::Regexp::HOST || host == 'localhost'
          errors.add :hosts, :invalid_format
          break
        end
      end
      if main_host =~ Exo::Regexp::HOST || main_host == 'localhost'
        self.hosts.push main_host
        self.hosts = self.hosts.uniq
      else
        errors.add :main_host, :invalid_format
      end
    end
  end
end