module Exo::Admin
  module SiteSlugIdFilter
    extend ActiveSupport::Concern

    included do
      include ::Exo::HostFilter
      extend ClassMethods
      
      before_filter do
        redirect_to exo.admin_root_url unless allowed_sites.include? exo_site.slug_id
      end
    end

    module ClassMethods
      def allow_sites *slug_ids
        @allowed_sites = slug_ids
      end

      def allowed_sites
        @allowed_sites || []
      end
    end
  end
end
  