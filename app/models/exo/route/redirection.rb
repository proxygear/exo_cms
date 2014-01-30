class Exo
  class Route::Redirection < Route
    field :to_url

    validates_presence_of :to_url
    #validates_format_of :to_path, with: Exo::Regexp::ABSOLUTE_PATH
  end
end