module Exo::ResourcesHelper
  TYPE_CONVERSION = {
    string: :string,
    text: :text,
    date: :ui_date_ticker,
    image: :file,
    markdown: :text
  }

  TYPE_CLASS = {
    text: :ckeditor,
    date: :datetime_ticker
  }

  def resource_input_for form, item, field
    type = field.datum_type.to_sym
    value = item.value_for field

    if type == :markdown
      render(
        partial: 'exo/admin/application/fields/markdown',
        locals: {form: form, field: field, value: value}
      )
    elsif [:image, :file].include?(type)
      render(
        partial: 'exo/admin/application/fields/' + (type == :image ? 'image' : 'file'),
        locals: {form: form, field: field, value: value}
      )
    else
      options             = {}
      html                = options[:input_html] = {}

      options[:required]  = field.required
      options[:required]  = false if !item.new_record?
      options[:label]     = field.name

      case field
      when Exo::Resource::MetaValue
        html[:class]       = TYPE_CLASS[type] if TYPE_CLASS[type]
        options[:as]      = TYPE_CONVERSION[type]
        
        hash = type == :text ? html : options
        if value.blank?
          hash[:value] = field.default
        else
          hash[:value] = value.form_value
        end
      when Exo::Resource::MetaRelation
        _resource = current_site.resource_name field.resource_slug_id
        options[:selected] = item.value_for(field).form_value
        options[:include_blank] = false
        options[:collection] = _resource.items.asc(:name).collect {|i| [i.name, i.id.to_s]}
        html[:multiple] = true
      end

      form.input field.slug_id, options
    end
  end

  def meta_errors_for item
    unless item.meta_errors.empty?
      render partial: 'meta_errors', locals: {item: item, resource: item.resource}
    end
  end
end