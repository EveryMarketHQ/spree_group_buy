module Spree::Stock::PackerDecorator

      def default_package
        package = Spree::Stock::Package.new(stock_location)

        # Group by line_item_id instead of variant_id.
        # in case of same variant_id of different line_item with group_buy_id enabled
        inventory_units.index_by(&:line_item_id).each do |line_item_id, inventory_unit|
          variant = Spree::Variant.find(inventory_unit.variant_id)
          unit = inventory_unit.dup # Can be used by others, do not use directly
          if variant.should_track_inventory?
            next unless stock_location.stocks? variant

            on_hand, backordered = stock_location.fill_status(variant, unit.quantity)
            package.add(Spree::InventoryUnit.split(unit, backordered), :backordered) if backordered.positive?
            package.add(Spree::InventoryUnit.split(unit, on_hand), :on_hand) if on_hand.positive?
          else
            package.add unit
          end
        end

        package
      end

end

Spree::Stock::Packer.prepend Spree::Stock::PackerDecorator