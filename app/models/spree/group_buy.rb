module Spree
  class GroupBuy < Spree::Base

    belongs_to :product
    has_many :line_items
  
    scope :active, -> { where(state: 'active') }
    
    before_validation :set_currency

    private

    def set_currency
      self.currency = Spree::Config[:currency] if currency.blank?
    end
    
  end
end