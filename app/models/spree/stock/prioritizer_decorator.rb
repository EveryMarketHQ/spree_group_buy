module Spree::Stock::PrioritizerDecorator

	  # use also line_item to differentiate each package item
	  # in case of same variant_id of different line_item with group_buy_id enabled
      def hash_item(item)
        shipment = item.inventory_unit.shipment
        variant  = item.inventory_unit.variant
        line_item = item.inventory_unit.line_item
        if shipment.present?
          variant.hash ^ line_item.hash ^ shipment.hash
        else
          variant.hash ^ line_item.hash
        end
      end

end

Spree::Stock::Prioritizer.prepend Spree::Stock::PrioritizerDecorator