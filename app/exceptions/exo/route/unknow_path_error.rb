class Exo::Route::UnknowPathError < Exception
  attr_accessor :host, :path
  
  def initialize host, path
    self.host = host
    self.path = path
    super "Unknow path #{path} for host #{host}"
  end
  
  def to_partial_path
    'exo/errors/unknow_path'
  end
end