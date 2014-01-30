class Exo
  class PagesController < ::Exo::ApplicationController
    before_filter :fix_lookup_context
    include RouteFilter

    def serve_page
      if tick.route.redirection?
        redirect_to tick.route.to_url
      else
        render tick.route.view_path, layout: tick.route.layout_path
      end
    end

    protected

    def fix_lookup_context
      # /!\ this is evil
      lookup_context.prefixes = [
        tick.site.theme_path,
        tick.site.nest_path('application')
      ]
    end
  end
end