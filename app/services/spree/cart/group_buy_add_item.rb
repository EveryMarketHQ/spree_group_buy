module Spree
  module Cart
    class GroupBuyAddItem
      prepend Spree::ServiceModule::Base

      def call(order:, variant:, quantity: nil, options: {})
        ApplicationRecord.transaction do
          run :add_to_line_item
          run Spree::Dependencies.cart_recalculate_service.constantize
        end
      end

      private

      def add_to_line_item(order:, variant:, quantity: nil, options: {})
        options ||= {}
        quantity ||= 1

        if options.key? :groupBuyId
          # finder by variant_id and group_buy_id
          line_item = order.line_items.detect do |line_item|
            line_item.variant_id == variant.id && line_item.group_buy_id == options[:groupBuyId].to_i 
          end
        else
          line_item = order.line_items.detect do |line_item|
            line_item.variant_id == variant.id && line_item.group_buy_id.nil?
          end

          # line_item = Spree::Dependencies.line_item_by_variant_finder.constantize.new.execute(order: order, variant: variant, options: options)
        end
        

        line_item_created = line_item.nil?
        if line_item.nil?
          opts = ::Spree::PermittedAttributes.line_item_attributes.flatten.each_with_object({}) do |attribute, result|
            result[attribute] = options[attribute]
          end.merge(currency: order.currency).delete_if { |_key, value| value.nil? }

          line_item = order.line_items.new(quantity: quantity,
                                           variant: variant,
                                           options: opts)
        else
          line_item.quantity += quantity.to_i
        end

        line_item.target_shipment = options[:shipment] if options.key? :shipment
        line_item.group_buy_id = options[:groupBuyId].to_i if options.key? :groupBuyId

        return failure(line_item) unless line_item.save

        if options.key? :groupBuyId
          line_item.price = options[:groupBuyPrice].to_f
          line_item.save

          line_item.group_buy.engaged_count += quantity.to_i
          line_item.group_buy.save
        else
          line_item.reload.update_price
        end
        
        ::Spree::TaxRate.adjust(order, [line_item]) if line_item_created
        success(order: order, line_item: line_item, line_item_created: line_item_created, options: options)
      end
    end
  end
end