class Exo::Site::UnknowHostError < Exception
  attr_accessor :host

  def initialize host
    self.host = host
    super "Unknow host #{host}"
  end
  
  def to_partial_path
    'exo/errors/unknow_host'
  end
end