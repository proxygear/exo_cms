class Exo
  class PagesController < ExoController
    before_filter :fix_lookup_context
    include RequestRestriction
    helper Exo::BlockHelper

    def serve_page
      if exo_router.route.redirection?
        redirect_to exo_router.route.to_url
      else
        render exo_router.route.view_path, layout: exo_router.route.layout_path
      end
    end

    protected
    def fix_lookup_context
      lookup_context.prefixes = [
        exo_site.theme_path,
        exo_site.nest_path('application')
      ]
    end
  end
end