module Spree::Api::V2::Storefront::CartControllerDecorator

    def add_item_service
      Spree::Cart::GroupBuyAddItem
    end
    
end

Spree::Api::V2::Storefront::CartController.prepend Spree::Api::V2::Storefront::CartControllerDecorator