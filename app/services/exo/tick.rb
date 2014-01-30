class Exo
  class Tick
    attr_accessor :site, :route, :request, :params

    def initialize host
      _site = Site.any_of([{hosts: host}, {main_host: host}]).first
      raise ::Exo::Site::UnknowHostError.new(host) unless _site
      self.site = SitePresenter.new _site
    end

    def services
      unless @services
        @services = {}
        site.services.each do |m|
          @services[m.name] = m.path
        end
        @services = @services.merge Exo.instance.services
      end
      @services
    end

    def domain_redirection?(host)
      site.main_host.to_s != host
    end

    def route! request #, params
      unless self.route
        Exo::PathMatcher.route_for(site.routes, request.params) do |route|
          self.route = Exo::RoutePresenter.new route
        end
        raise ::Exo::Route::UnknowPathError.new site.main_host, request.path unless route
      end
      self.route
    end
  end
end