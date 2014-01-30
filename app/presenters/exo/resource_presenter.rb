class Exo
  class ResourcePresenter
    attr_accessor :resource

    def initialize resource
      self.resource = resource
    end

    def items
      ScopeWraper.new resource.items, self
    end
    
    def item slug_id
      ItemPresenter.new items.find_by(slug_id: slug_id), self
    end

    def meta_field name
      resource.meta_fields.where(slug_id: name.to_s).first
    end

    def wrap_item i
      ItemPresenter.new i, self
    end
  end
end