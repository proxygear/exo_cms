class Exo::Block
  include Exo::Document
  
  embedded_in :page, class_name: 'Exo::Route::Page'
  
  field :slug_id
  field :content

  validates_presence_of :slug_id
  validates_presence_of :content
end