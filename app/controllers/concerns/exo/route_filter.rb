class Exo
  module RouteFilter
    extend ActiveSupport::Concern

    included do
      before_filter :exo_path_routing!

      expose(:exo_route) { exo_routing.route }

      rescue_from Exo::Route::UnknowPathError do |e|
        render e, status: 404
      end
    end

    protected
    def exo_path_routing!
      exo_routing.for_request! request
    end
  end
end
  