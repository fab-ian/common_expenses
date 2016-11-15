class ItemUser < ApplicationRecord
  belongs_to :item
  belongs_to :user

  scope :get_participants, ->(item_id) { includes(:user).where(item_id: item_id) }
end
