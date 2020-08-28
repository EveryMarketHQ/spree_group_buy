module Spree::LineItemDecorator
	def self.prepended(base)
		base.belongs_to :group_buy, class_name: 'Spree::GroupBuy'
	end

	include Spree::VatPriceCalculation

    def update_price
      if group_buy_id?
      	self.price = gross_amount(group_buy.price, {tax_zone: tax_zone, tax_category: variant.tax_category})
      else
	    self.price = variant.price_including_vat_for(tax_zone: tax_zone)
	  end
    end

end

Spree::LineItem.prepend Spree::LineItemDecorator