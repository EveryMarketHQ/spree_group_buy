module Spree
  class GroupBuy < Spree::Base

    belongs_to :product
  
    scope :active, -> { where(state: 'active') }

  end
end