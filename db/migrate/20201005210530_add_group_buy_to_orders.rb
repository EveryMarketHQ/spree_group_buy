class AddGroupBuyToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_orders, :group_buy, :boolean, default: false, after: 'considered_risky'
  end
end
