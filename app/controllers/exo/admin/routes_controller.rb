module Exo::Admin
  class RoutesController < Exo::AdminController
    expose(:current_route) do
      exo_site.routes.find params[:id]
    end

    def edit
      render 'edit', layout: 'exo/admin/editor'
    end
  end
end