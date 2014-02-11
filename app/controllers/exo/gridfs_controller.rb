class Exo
  class GridfsController < ExoController
    def item_asset
      item = exo_site.resource(params[:resource_slug_id]).items.find_by slug_id: params[:item_slug_id]
      asset = item.send params[:field_slug_id].to_sym
      respond_with_asset asset
    end

    def asset
      asset = exo_site.slug_scope(Exo::Asset).find_by _id: params[:id]
      if asset
        respond_with_asset asset
      else
        render text: "Asset not found", status: 500
      end
    end

    protected
    def respond_with_asset asset
      response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
      response.headers['Content-Type'] = asset.content_type
      response.headers['Content-Disposition'] = 'inline'
      content = asset.content
      version = params[:file_name].split('_').first
      version = version.to_sym if version
      if Exo::UploadVersions::VERSIONS.keys.include?(version)
        content = content.send version
      end
      render text: content.read, status: 200
    end
  end
end