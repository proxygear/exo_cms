class Exo
  class Resource::Item
    class BelongsToValue < AbstractRelation
      field :item_id, type: String, default: nil

      before_validation :clean_blank_item_id
      validate :item_existance, if: :item_id

      def form_value
        item_id
      end

      protected
      def item_existance
        raise "SHOULD USE SLUG ID"
        unless resource!.items.where(_id: item_id).exists?
          errors.add :item_id, :invalid
        end
      end

      def clean_blank_item_id
        self.item_id = nil if self.item_id.blank?
      end
    end
  end
end