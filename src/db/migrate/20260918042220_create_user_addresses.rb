class CreateUserAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :user_addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :postal_code
      t.integer :prefecture
      t.string :city
      t.string :address_line1
      t.string :address_line2
      t.string :phone_number

      t.datetime :discarded_at

      t.timestamps
    end

    add_index :user_addresses, :discarded_at
  end
end
