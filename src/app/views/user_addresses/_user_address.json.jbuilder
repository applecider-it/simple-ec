json.extract! user_address, :id, :user_id, :postal_code, :prefecture, :city, :address_line1, :address_line2, :phone_number, :created_at, :updated_at
json.url user_address_url(user_address, format: :json)
