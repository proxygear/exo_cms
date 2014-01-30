class Exo::Admin::SessionsController < Devise::SessionsController
  protected
  def after_sign_in_path_for(resource)
    '/admin'
  end
end