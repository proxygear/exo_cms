require 'mongoid'
require 'devise'
require "exo/engine"
require 'exo/regexp'
require 'exo/railtie' if defined?(Rails)

class Exo
  include Singleton

  def self.config &block
    block.call self.instance
  end

  attr_accessor :services

  def initialize
    self.services = {}
  end

  def register_services hash
    self.services = hash
  end
end

# Exo.config do |s|
#   s.generic_services(
#     'Messages' => '/somepath'
#   )
# 
#   s.register_models(
#     SomeNamespace::AModel,
#     SomeNamespace::AnotherModel
#   )
# end
