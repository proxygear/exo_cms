=begin
   ------
  /\/  \/\
 / /\  /\ \
/ /_ \/  \ \
\ \  /\  / / 
 \ \/  \/ /
  \/\  /\/
  -------- CMS
=end

require 'mongoid'
require 'devise'
require "exo/engine"
require 'exo/regexp'

class Exo
  include Singleton

  def self.config &block
    block.call self.instance
  end

  attr_accessor :services

  def initialize
    self.services = []
  end

  def register_services hash
    hash.each do |name, path|
      self.services = AppService.new name, path
    end
  end
end

# Exo.config do |s|
#   s.generic_services(
#     'Messages' => '/somepath'
#   )
# end
