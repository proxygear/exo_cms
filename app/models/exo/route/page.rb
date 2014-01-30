class Exo
  class Route::Page < Route
    field :view_path
    field :layout_path, type: String

    embeds_many :blocks, class_name: 'Exo::Block'

    validates_format_of :view_path, with: Exo::Regexp::ABSOLUTE_PATH
    validates_format_of :layout_path, with: Exo::Regexp::ABSOLUTE_PATH, if: :layout_path
  end
end