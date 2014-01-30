module Exo::Admin
  class ContributorsController < ApplicationController
    expose(:contributor) { current_site.contributors.find params[:id] }
  end
end