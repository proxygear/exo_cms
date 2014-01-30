class Exo
  class Resource::Item
    class HasManyValue < AbstractRelation
      field :item_ids, type: Array, default: Array

      validate :item_existance

      def form_value
        items_ids
      end

      protected
      def item_existance
        raise "SHOULD USE SLUG ID"
        items_ids.each do |id|
          unless resource!.items.where(_id: id).exists?
            errors.add :item_ids, :invalid
            break
          end
        end
      end
    end
  end
end