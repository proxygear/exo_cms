module Exo::Admin
  class ContributorsController < Exo::AdminController
    expose(:contributor) { exo_site.contributors.find params[:id] }
  end
end