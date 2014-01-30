class Exo
  class ScopeWraper
    attr_accessor :_scope, :delegate

    include Enumerable

    def initialize scope, delegate=nil
      self.delegate = delegate
      self._scope = scope.kind_of?(Exo::ScopeWraper) ? scope._scope : scope
    end

    def each &block
      if delegate
        _scope.each do |item|
          block.call delegate.wrap_item(item)
        end
      else
        _scope.each &block
      end
    end

    def keep? obj
      obj.kind_of? ::Mongoid::Criteria
    end

    def first
      wrap _scope.first
    end
    
    def last
      wrap _scope.last
    end

    def find *params
      wrap _scope.find *params
    end

    def find_by *params
      wrap _scope.find_by *params
    end

    def method_missing meth, *args, &block
      _rez = _scope.send meth, *args, &block
      if keep? _rez
        self._scope = _rez
        self
      else
        _rez
      end
    end
    
    protected
    def wrap item
      item = delegate.wrap_item(item) if delegate
      item
    end
  end
end