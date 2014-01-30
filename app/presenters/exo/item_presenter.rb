class Exo
  class ItemPresenter
    attr_accessor :item, :resource

    def initialize item, decorated_resource=nil
      self.item = item
      self.resource = decorated_resource || ResourcePresenter.new(item.resource)
    end

    def method_missing meth, *params, &block 
      _field = resource.meta_field(meth)
      if _field
        item.value_for _field
      else
        item.send meth, *params, &block
      end
    end
  end
end