class Exo
  class Router
    attr_accessor :site, :route, :request, :params

    def self.for_host! host
      site = Site.any_of([{hosts: host}, {main_host: host}]).first
      raise ::Exo::Site::UnknowHostError.new(host) unless site
      new site
    end

    def initialize site
      self.site = SiteDecorator.new site
    end

    def domain_redirection?(host)
      site.main_host.to_s != host
    end

    def host_url path=''
      "http://#{site.main_host}#{path}"
    end

    def for_request! request
      unless self.route
        Exo::PathMatcher.route_for(site.routes, request.params) do |route|
          self.route = Exo::RouteDecorator.new route
        end
        raise ::Exo::Route::UnknowPathError.new site.main_host, request.path unless route
      end
      self.route
    end
  end
end