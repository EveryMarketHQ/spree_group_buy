module Spree::ProductDecorator
  def self.prepended(base)
    base.has_many :group_buys, class_name: 'Spree::GroupBuy'
  end
end

Spree::Product.prepend Spree::ProductDecorator