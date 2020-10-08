module Spree::Admin::OrdersControllerDecorator

      def resend
        if @order.group_buy?
          Spree::OrderMailer.groupbuy_confirm_email(@order.id, true).deliver_later
        else
          Spree::OrderMailer.confirm_email(@order.id, true).deliver_later
        end
        flash[:success] = Spree.t(:order_email_resent)

        redirect_back fallback_location: spree.edit_admin_order_url(@order)
      end


end

Spree::Admin::OrdersController.prepend Spree::Admin::OrdersControllerDecorator