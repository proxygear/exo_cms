module Exo::Admin
  class ItemsController < Exo::Admin::ApplicationController
    MODEL = Exo::Resource::Item

    expose(:current_resource) { tick.site.site.resources.find params[:resource_id] }
    expose(:current_item) do
      if [:new, :create].include? params[:action].to_sym
        MODEL.new item_params
      else
        current_resource.items.find params[:id]
      end
    end

    def create
      current_item.site = current_site
      current_item.resource = current_resource

      update
    end

    def update
      item_builder.update_values values_params
      if item_builder.update_item item_params
        redirect_to admin_resource_item_url(current_resource, current_item)
      else
        redirect_to admin_resource_url(current_resource)
        #render current_item.new_record? ? 'edit' : 'new'
      end
    end

    def destroy
      current_item.destroy
      redirect_to admin_resources_url(current_resource)
    end

    protected
    def item_builder
      @item_builder ||= Exo::ItemBuilder.new current_item
    end
  
    # def update_assets_on asset_holder
    #   asset_params.each do |k, v|
    #     asset_holder.set_asset k, v
    #   end
    # end
    # 
    # def asset_params
    #   unless @asset_params
    #     @asset_params = {}
    #     current_resource.meta_fields.each do |f|
    #       next unless f.kind_of?(Exo::Resource::MetaValue) && f.asset?
    #       puts "asset detected #{f.slug_id.to_sym}"
    #       @asset_params[f.slug_id.to_sym] = params[:item][:values][f.slug_id.to_sym]
    #     end
    #   end
    #   @asset_params
    # end

    def item_params
      allow_params :item, [:name, :published]
    end

    def values_params
      params[:item][:values] || {}
    end

    # def meta_field_keys
    #   Array.new.tap do |keys|
    #     current_resource.meta_fields.each do |f|
    #       next if f.kind_of?(Exo::Resource::MetaValue) && f.asset?
    #       if f.kind_of?(Exo::Resource::MetaRelation) && f.many
    #         keys.push(f.slug_id.to_sym => [])
    #       else
    #         keys.push f.slug_id.to_sym
    #       end
    #     end
    #   end
    # end
  end
end