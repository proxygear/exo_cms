module Exo::Admin
  class ResourcesController < Exo::Admin::ApplicationController
    expose(:current_resource) { current_site.resources.find params[:id] }
  end
end