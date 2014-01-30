class Exo::Resource::MetaErrors
  attr_accessor :errors

  def initialize
    self.errors = {}
  end

  def each &block
    errors.each &block
  end

  def collect &block
    errors.collect &block
  end

  def add slug_id, error_type
    errors[slug_id] ||= []
    errors[slug_id].push error_type unless errors[slug_id].include?(error_type)
  end
  
  def empty?
    errors.empty?
  end
end