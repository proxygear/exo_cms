class Exo
  class ResourceDecorator < Draper::Decorator
    delegate_all

    def items
      ScopeWraper.new resource.items, self
    end
    
    def item_name slug_id
      wrap_item items.find_by(slug_id: slug_id)
    end

    def meta_field_name name
      resource.meta_fields.where(slug_id: name.to_s).first
    end

    def wrap_item item
      ItemDecorator.new item if item
    end
  end
end