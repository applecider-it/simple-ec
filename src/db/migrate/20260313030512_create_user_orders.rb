class CreateUserOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :user_orders do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :user_orders, :discarded_at
  end
end
