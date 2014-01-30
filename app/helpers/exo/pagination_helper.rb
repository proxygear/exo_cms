class Exo
  module PaginationHelper
    def paginate_scope scope
      scope
    end
    
    def paginate scope
      Pagination.new scope, params
    end
  end
  
  class Pagination < Struct.new(:scope, :params)
    def pages
      [1]
    end

    def method_missing meth
      nil
    end
  end
end