class Expense < ApplicationRecord
  belongs_to :item
  has_many :expense_users
end
