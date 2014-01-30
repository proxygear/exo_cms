class Exo
  class Resource::Item
    class ListValue < AbstractValue
      JOIN_SEPARATOR = ', '
      SPLIT_REGEXP = /,\s*/


      field :array_values, type: Array, default: []

      def form_value
        list_value
      end

      def list_value
        array_values.join JOIN_SEPARATOR
      end

      def list_value= list
        self.array_values = list.split SPLIT_REGEXP
      end
    end
  end
end