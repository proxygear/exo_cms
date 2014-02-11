module Exo::Admin
  class ResourcesController < Exo::AdminController
    expose(:current_resource) { exo_site.resources.find params[:id] }
  end
end