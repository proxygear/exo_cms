class Exo
  module RequestRestriction
    extend ActiveSupport::Concern

    included do
      before_filter :exo_request_routing!

      expose(:exo_route) { exo_router.route }

      rescue_from Exo::Route::UnknowPathError do |e|
        render e, status: 404
      end
    end

    protected
    def exo_request_routing!
      exo_router.for_request! request
    end
  end
end
  