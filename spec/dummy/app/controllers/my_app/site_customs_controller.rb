module MyApp
  class SiteCustomsController < ApplicationController
    include ::Exo::Admin::SiteSlugIdFilter

    protected
    def allowed_sites
      ['a_site_slug_id', 'another_site_slug_id']
    end
  end
end