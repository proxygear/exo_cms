module Exo::Admin
  class RoutesController < Exo::Admin::ApplicationController
    expose(:current_route) do
      current_site.routes.find params[:id]
    end

    def edit
      render 'edit', layout: 'exo/admin/editor'
    end
  end
end