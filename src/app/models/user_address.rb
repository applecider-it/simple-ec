class UserAddress < ApplicationRecord
  belongs_to :user

  validates :postal_code, :prefecture, :city, :address_line1, presence: true
end
