class AddGroupBuyToLineItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :spree_line_items, :group_buy
  end
end
