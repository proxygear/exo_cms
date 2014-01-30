class Exo
  class Resource::Item
    class AbstractRelation < AbstractValue
      field :resource_slug_id

      validates_presence_of :resource_slug_id
      validate :resource_existance, if: :item

      protected
      def resource_existance
        resource!
      rescue ::Mongoid::Errors::DocumentMissing => e
        errors.add :resource_slug_id, :invalid
      end

      def resource!
        item.site.slug_scope(Exo::Resource).find_by slug_id: resource_slug_id
      end
    end
  end
end