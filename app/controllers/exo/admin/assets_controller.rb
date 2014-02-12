module Exo::Admin
  class AssetsController < Exo::AdminController
    MODEL = Exo::Asset
    expose(:assets) { exo_site.slug_scope(MODEL).asc(:created_at) }
    expose(:current_asset) do
      if [:new, :create].include? params[:action].to_sym
        MODEL.new asset_params
      else
        exo_site.slug_scope(MODEL).find params[:id]
      end
    end

    def create
      current_asset.site = exo_site
      #current_asset.content = params[:upload]
      if current_asset.save
        redirect_to admin_assets_url
      else
        render 'new'
      end
    end

    def update
      if current_asset.update_attributes(asset_params)
        redirect_to admin_assets_url
      else
        render 'edit'
      end
    end

    def destroy
      current_asset.destroy
      redirect_to admin_assets_url
    end

    protected
    def asset_params
      allow_params :asset, [:name, :content, :upload]
    end
  end
end