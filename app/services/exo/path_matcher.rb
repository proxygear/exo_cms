class Exo
  class PathMatcher
    def self.test
      raise '1' unless new('/home').match?('/home')
    
      hash = {}
      raise '2' unless new('/home/:test').match?('/home/a', hash)
      raise '3' unless hash[:test] == 'a'
    
      hash = {}
      raise '4' unless new('/home/:test/another/:lol').match?('/home/abc/another/def', hash)
      raise '5' unless hash[:test] == 'abc'
      raise '6' unless hash[:lol] == 'def'
    
      hash = {}
      raise '7' unless new('/home/:test/another/:lol/fun').match?('/home/abc/another/def/fun', hash)
      raise '8' unless hash[:test] == 'abc'
      raise '9' unless hash[:lol] == 'def'
    end  

    attr_accessor :regexp, :keys
    def self.route_for routes, params, key=:route_path, &builder
      path = params[key]
      raise "Params does not countain any path" unless path
      path = "/#{path}" unless path[0] == '/'

      routes.each do |route|
        if new(route.path).match? path, params
          builder.call route
          break
        end
      end
    end
    
    def initialize path_pattern
      self.keys = []
      regpath = path_pattern.gsub(/:([^\/]+)/) do |match|
        key = $1
        keys.push key.to_sym
        "(?<#{key}>.+)"
      end
      self.regexp = /\A#{regpath}\z/i
    end
    
    def match? path, params=nil
      matching = regexp.match path
      if matching && params
        keys.each do |k|
          params[k] = matching[k]
        end
      end
      !!matching
    end
  end
end