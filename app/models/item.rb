class Item < ApplicationRecord
  has_many :item_users
  has_many :expenses
  has_many :payments
end
