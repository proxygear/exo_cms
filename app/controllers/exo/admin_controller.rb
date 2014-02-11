class Exo
  class AdminController < ExoController
    layout 'exo/admin/application'

    before_filter :authenticate_contributor!

    protected
    def allow_params key, fields
      params.permit(key => fields)[key]
    end
  end
end