module Exo::Admin
  class SettingsController < Exo::Admin::ApplicationController
    skip_before_filter :verify_authenticity_token, only: :create

    MODEL = Exo::Setting

    before_filter :current_route, if: :for_route?
    helper_method :for_route?

    expose(:settings) { current_site.settings }
    expose(:current_setting) do
      if [:new, :create].include? params[:action].to_sym
        MODEL.new new_setting_params
      else
        parent = for_route? ? current_route : current_site
        parent.settings.find params[:id]
      end
    end
    expose(:current_route) do
      current_site.routes.find params[:route_id]
    end

    def create
      current_setting.setting_container = for_route? ? current_route : current_site
      if current_setting.save
        redirect_to_parent
      else
        render 'new'
      end
    end

    def update
      if current_setting.update_attributes update_setting_params
        redirect_to_parent
      else
        render 'edit'
      end
    end

    def destroy
      if current_setting.system
        flash[:alert] = "This is a system setting and cannot be required"
      else
        current_setting.destroy
      end
      redirect_to_parent
    end

    protected
    def redirect_to_parent
      redirect_to for_route? ? admin_route_url(current_route) : admin_settings_url
    end

    def for_route?
      !params[:route_id].blank?
    end

    def new_setting_params
      allow_params :setting, [:name, :slug_id, :value]
    end
    
    def update_setting_params
      allow_params :setting, [:name, :value]
    end
  end
end