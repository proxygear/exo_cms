class Exo
  class SiteDecorator < Draper::Decorator
    delegate_all

    def resource_name name
      name = name.to_s
      if _resources[name] == nil
        resource = object.resources.where(slug_id: name).first
        decorated_resources[name] = resource ? ResourceDecorator.new(resource) : false
      end
      _resources[name]
    end

    def setting_name name
      self.object.settings.where(slug_id: name.to_sym).first
    end

    protected
    attr_accessor :_resources

    def _resources
      @_resources ||= {}
    end
  end
end