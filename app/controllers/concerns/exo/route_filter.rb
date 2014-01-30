class Exo
  module RouteFilter
    extend ActiveSupport::Concern

    included do
      before_filter :route_ticking!
      
      rescue_from Exo::Route::UnknowPathError do |e|
        render e, status: 404
      end
    end
    
    protected
    def route_ticking!
      tick.route! request
    end
  end
end
  