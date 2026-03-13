class CreateUserOrderDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :user_order_details do |t|
      t.references :user_order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :amount
      t.integer :price
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :user_order_details, :discarded_at
  end
end
