module Spree::OrderDecorator

	def self.prepended(base)
		base.whitelisted_ransackable_attributes = %w[completed_at email number state payment_state shipment_state total considered_risky group_buy channel]
	end

    def update_line_item_prices!
      transaction do
        line_items.reload.each(&:update_price)
        save!
      end

      check_group_buy
    end

    def finalize!
      # lock all adjustments (coupon promotions, etc.)
      all_adjustments.each(&:close)

      # update payment and shipment(s) states, and save
      updater.update_payment_state
      shipments.each do |shipment|
        shipment.update!(self)
        shipment.finalize!
      end

      updater.update_shipment_state
      save!
      updater.run_hooks

      touch :completed_at

      if is_group_buy?
      	deliver_order_confirmation_email unless confirmation_delivered?
	  else
	  	deliver_order_confirmation_email unless confirmation_delivered?
	  end

      consider_risk
    end

    def check_group_buy
    	update_column(:group_buy, is_group_buy?)
    end

    def is_group_buy?
      line_items.each do |line_item|
      	return true if line_item.group_buy_id?
      end
      return false
    end

end

Spree::Order.prepend Spree::OrderDecorator