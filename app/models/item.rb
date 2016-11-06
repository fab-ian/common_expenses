class Item < ApplicationRecord
  has_many :item_users, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :payments, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
end
