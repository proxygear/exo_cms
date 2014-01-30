module Exo::Admin
  class ApplicationController < ::Exo::ApplicationController
    layout 'exo/admin/application'
    before_filter :authenticate_contributor!
    expose(:current_site) { tick.site.site }

    protected
    def allow_params key, fields
      params.permit(key => fields)[key]
    end
  end
end