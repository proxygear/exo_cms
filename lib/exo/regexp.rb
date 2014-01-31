class Exo
  module Regexp
    HOST = /\A([a-z0-9-]+\.)*[a-z0-9-]+\.[a-z]{2,4}\z/
    REL_PATH = /\A[a-z0-9_]+(\/[a-z0-9_]+)*\z/
    ABSOLUTE_PATH = /\A\/([a-z0-9_]+\/)*([a-z0-9_]+(\.[a-z0-9_]+)?)?\z/
    ROUTING_PATH = /\A\/((:|\*)?[a-z0-9_]+\/)*((:|\*)?[a-z0-9_]+(\.[a-z0-9_]+)?)?\z/
  end
end