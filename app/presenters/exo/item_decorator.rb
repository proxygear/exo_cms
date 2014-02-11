class Exo
  class ItemDecorator < Draper::Decorator
    delegate_all

    def decorated_resource
      @decorated_resource ||= wrap_resource item.resource
    end

    alias :resource :decorated_resource

    def method_missing method, *params, &block
      if meta_field = resource.meta_field method
        item.value_for meta_field
      else
        item.send method, *params, &block
      end
    end

    def wrap_resource resource
      ResourceDecorator.new resource if resource
    end
  end
end