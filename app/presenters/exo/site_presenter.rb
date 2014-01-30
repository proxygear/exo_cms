class Exo
  class SitePresenter
    attr_accessor :site, :_resources

    def initialize site
      self.site = site
      self._resources = {}
    end

    def resource name
      name = name.to_s
      _resources[name] = decorated_resource name if _resources[name] == nil
      _resources[name] || nil
    end

    def setting name
      self.site.settings.where(slug_id: name.to_sym).first
    end

    def routes
      site.routes
    end

    def method_missing meth, *args, &block
      site.send meth.to_sym, *args, &block
    end

    protected
    def decorated_resource name
      _resource = self.site.resources.where(slug_id: name).first || false
      _resource = ResourcePresenter.new _resource if _resource
      _resource
    end
  end
end