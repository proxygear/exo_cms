class Exo
  module HostFilter
    extend ActiveSupport::Concern

    included do
      before_filter :exo_host_acceptance!
      before_filter :exo_host_redirection!

      expose(:exo_site) { exo_routing.site }

      rescue_from ::Exo::Site::UnknowHostError do |e|
        render e, status: 503
      end
    end

    protected
    def exo_routing
      @exo_routing
    end

    def exo_host_acceptance!
      @exo_routing = Router.for_host! request.host
    end

    def exo_host_redirection!
      if exo_routing.domain_redirection?(request.host)
        redirect_to exo_routing.host_url(request.path)
      end
    end
  end
end
  