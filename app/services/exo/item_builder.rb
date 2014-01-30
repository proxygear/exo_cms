class Exo::ItemBuilder < Struct.new(:item)
  def update_values params
    puts "[Exo::ItemBuilder] Update values ..."
    _resource = item.resource
    params.each do |k, v|
      puts " * #{k}"
      _field = _resource.meta_field_for k
      _value = item.value_for k

      if _value && _value.class != _field.value_class
        _value.destroy
        _value = nil
      end

      unless _value
        _value = _field.value_class.new
        _value.field_slug_id = k.to_s
        _value.item = item
      end

      _value.value_update v

      puts "=> #{item.values.inspect}"
    end
  end
  
  def update_item params
    puts "[Exo::ItemBuilder] Update item ..."
    if item.new_record?
      item.save
    else
      item.update_attributes params
    end
    # Values post save is required to trigger assets content to persist.
    item.values.each do |r|
      r.save!
    end
  end
end