class Expense < ApplicationRecord
  belongs_to :item
  has_many :expense_users, dependent: :destroy
  has_one :payment, dependent: :destroy

  validates :name, :amount, presence: true
end
