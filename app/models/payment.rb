class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :expense

  validates :amount, presence: true
end
