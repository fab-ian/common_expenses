class Item < ApplicationRecord
  has_many :item_users, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :payments, dependent: :destroy
  belongs_to :user

  validates :name, presence: true

  scope :my_items, ->(user_id) { where(user_id: user_id) }

  scope :items_which_i_participate, (lambda do |user_id|
    joins(:item_users).where('items.user_id <> ? AND item_users.user_id = ?', user_id, user_id)
  end)

  scope :allow_show, (lambda do |user_id|
    joins(:item_users).where('item_users.user_id = ?', user_id)
  end)
end
