class Exo
  class Resource::Item
    class SimpleValue < AbstractValue
      field :value
      
      def form_value
        value
      end

      def value_update value
        self.value = value
      end
    end
  end
end