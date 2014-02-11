class ExoController < ActionController::Base
  protect_from_forgery with: :exception
  include ::Exo::HostFilter
end