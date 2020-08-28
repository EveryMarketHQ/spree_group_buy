module Spree
  module Admin
    class GroupBuysController < ResourceController
      belongs_to 'spree/product', find_by: :slug
      before_action :find_group_buys, only: :index

      private

      def find_group_buys
        @group_buys = @product.group_buys
      end

    end
  end
end