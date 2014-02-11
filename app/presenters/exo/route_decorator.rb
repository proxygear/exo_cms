class Exo
  class RouteDecorator < Draper::Decorator
    DEFAULT_LAYOUT = '/application'

    delegate_all

    def redirection?
      object.class == Exo::Route::Redirection
    end

    def view_path
      object.site.nest_path object.view_path
    end

    def layout_path
      object.site.nest_path(object.layout_path || DEFAULT_LAYOUT)
    end

    def block_name slug_id
      object.blocks.where(slug_id: slug_id.to_s).first
    end
  end
end