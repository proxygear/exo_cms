class Exo
  module HostFilter
    extend ActiveSupport::Concern

    included do
      expose(:tick) { Tick.new request.host }
      before_filter :tick_host!

      rescue_from ::Exo::Site::UnknowHostError do |e|
        render e, status: 503
      end
    end

    protected
    def tick_host!
      if tick.domain_redirection?(request.host)
        redirect_to "http://#{self.tick.site.main_host}#{request.path}"
      end
    end
  end
end
  