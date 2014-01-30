class Exo
  class RoutePresenter < Struct.new(:route)
    DEFAULT_LAYOUT = '/application'

    def redirection?
      route.class == Exo::Route::Redirection
    end
    
    def nil?
      route.nil?
    end

    def to_url
      route.to_url
    end

    def view_path
      route.site.nest_path route.view_path
    end

    def layout_path
      route.site.nest_path(route.layout_path || DEFAULT_LAYOUT)
    end

    def blocks
      route.blocks
    end

    def block slug_id
      route.blocks.where(slug_id: slug_id.to_s).first
    end
  end
end