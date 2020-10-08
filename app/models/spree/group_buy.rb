module Spree
  class GroupBuy < Spree::Base

    belongs_to :product, touch: true
    has_many :line_items
    has_many :orders, through: :line_items

    scope :active, -> { where(state: 'active') }
    
    before_validation :set_currency

    def display_price
      Spree::Money.new(price || 0, currency: currency)
    end
    
    def completed_orders
      orders.select(&:completed?)
    end

    def completed_pending_orders
      orders.select { |o| o.completed? and o.payment_state == "balance_due" }
    end

    def completed_paid_orders
      orders.select { |o| o.completed? and o.payment_state == "paid" }
    end

    def active?
      state == 'active'
    end

    def capture_payments!
        completed_pending_orders.each do |order| 
          order.payments.each do |payment| 
            payment.send("capture!")
          end
        end
    end

    def void_payments!
        completed_pending_orders.each do |order| 
          order.payments.each do |payment| 
            payment.send("void_transaction!")
          end
        end
    end

    def is_expired?
      expires_at < DateTime.now
    end

    def goal_accomplished?
      completed_pending_orders.length >= quantity
    end

    def set_accomplished!
      update_column(:state, 'accomplished')
    end

    def set_failed!
      update_column(:state, 'failed')
    end


    private

    def set_currency
      self.currency = Spree::Config[:currency] if currency.blank?
    end

  end
end