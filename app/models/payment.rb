class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :name, :amount, presence: true
end
