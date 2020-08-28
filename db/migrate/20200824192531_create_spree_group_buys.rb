class CreateSpreeGroupBuys < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_group_buys do |t|
    	t.references :product
    	t.integer :quantity,  null: false
    	t.decimal :price, precision: 8, scale: 2
      t.string :currency
    	t.datetime :expires_at
    	t.integer :engaged_count,  default: 0,  null: false
    	t.string   :state
      	t.timestamps
    end

  end
end
