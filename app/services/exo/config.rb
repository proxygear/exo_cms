class Exo
  class Config
    attr_accessor :config_slug, :options
    def initialize config_slug, options
      self.config_slug = config_slug
      self.options = options
    end
    
    def install!
      raise 'Target missing! specify it this way "seed[site_name]"' if config_slug.blank?

      _site_conf = load_site_config config_slug
      _site = up_site config_slug, _site_conf
      _site.save!

      if path = ViewGenerator.ensure_site_layout(_site)
        puts " + #{path}".colorize(:green)
      end

      (_site_conf[:resources] || []).each do |_slug, _conf|
        r = up_resource _slug, _site, _conf
        r = r.save!
      end

      (_site_conf[:routes] || []).each do |_slug, _conf|
        r = up_route _slug, _site, _conf
        r.save!
        if r.class == Exo::Route::Page
          if path = ViewGenerator.ensure_page_view(r)
            puts " + #{path}".colorize(:green) 
          end
        end
        #FIXME: r.clean_item_fields
      end
    end

    protected
    def load_site_config slug
      _hash = YAML.load_file File.join(
        Rails.root,
        'config',
        'exo',
        "#{slug}.yml"
      )
      HashWithIndifferentAccess.new _hash
    end

    def up_site slug, conf
      m = Site.where(slug_id: slug).first || Site.new

      m.slug_id = slug
      m.main_host = conf[:main_host]
      m.hosts = conf[:hosts] || []
      m.theme_path = conf[:theme]

      (conf[:contributors] || []).each do |email|
        c = Exo::Contributor.where(email: email).first
        unless c
          puts " ! Contributor #{email} not registred"
          next
        end
        unless m.contributor_ids.include?(c.id)
          puts " + contributor #{email}"
          m.contributors.push c
        end
      end
      m
    end
    
    def up_route slug, site, conf
      route = site.routes.where(path: conf[:path]).first

      _is_page = conf[:to].blank?
      _class = _is_page ? Route::Page : Route::Redirection

      if route && route.class != _class
        puts " ! change route type for #{route.path}"
        route.destroy
        route = nil
      end

      unless route
        puts " + #{conf[:path]}"
        route = _class.new
      end

      route.slug_id = slug
      route.path = conf[:path]
      if _is_page
        route.view_path = conf[:view]
      else
        route.to_url = conf[:to]
      end

      route.site = site unless route.site
      route
    end

    def up_resource slug, site, fields
      fields ||= {}

      r = site.resources.where(slug_id: slug).first

      unless r
        puts " + resource #{slug}"
        r = Resource.new
      end
      
      r.slug_id = slug
      r.name = slug
      
      fields.each do |name, opt|
        if opt[:resource]
          f = Resource::MetaRelation.new
          f.resource_slug_id = opt[:resource]
          f.many = opt[:type].to_sym == :many
          if f.many
            f.slug_id = "#{name}_ids"
          else
            f.slug_id = "#{name}_id"
          end
        else
          f = Resource::MetaValue.new
          f.slug_id = name
          f.datum_type = opt[:type]
          f.unique = !!opt[:unique]
        end
        f.name = opt[:name] || name
        f.required = !!opt[:required]
        
        f.resource = r
      end

      r.site = site unless r.site
      r
    end
  end
end