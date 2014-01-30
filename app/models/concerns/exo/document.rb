module Exo::Document
  extend ActiveSupport::Concern
  
  included do
    include Mongoid::Document
    include Mongoid::Timestamps
  end
end