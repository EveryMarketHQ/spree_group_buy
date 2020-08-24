class CreateSpreeGroupBuys < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_group_buys do |t|
    	t.references :product
    	t.integer :quantity,  null: false
    	t.decimal :price, precision: 8, scale: 2
    	t.datetime :expires_at
    	t.integer :engaged_count,  default: 0,  null: false
    	t.string   :state
      	t.timestamps
    end

    add_index :spree_group_buys, [:product_id], name: 'index_spree_group_buys_on_product_id'
  end
end
