module Spree
  class GroupBuy < Spree::Base

    belongs_to :product, touch: true
    has_many :line_items
  
    scope :active, -> { where(state: 'active') }
    
    before_validation :set_currency

    def display_price
      Spree::Money.new(price || 0, currency: currency)
    end

    private

    def set_currency
      self.currency = Spree::Config[:currency] if currency.blank?
    end
    
  end
end