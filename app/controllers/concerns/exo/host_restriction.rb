class Exo
  module HostRestriction
    extend ActiveSupport::Concern

    included do
      before_filter :exo_host_acceptance!
      before_filter :exo_host_redirection!

      expose(:exo_site) { exo_router.site }

      rescue_from ::Exo::Site::UnknowHostError do |e|
        render e, status: 503
      end
    end

    protected
    def exo_router
      @exo_router
    end

    def exo_host_acceptance!
      @exo_router = Router.for_host! request.host
    end

    def exo_host_redirection!
      if exo_router.domain_redirection?(request.host)
        redirect_to exo_router.host_url(request.path)
      end
    end
  end
end
  