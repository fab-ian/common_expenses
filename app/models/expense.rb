class Expense < ApplicationRecord
  belongs_to :item
  has_many :expense_users, dependent: :destroy
  has_one :payment, dependent: :destroy

  validates :name, :amount, presence: true

  after_update :update_payment_amount

  def update_payment_amount
    payment.update(amount: amount)
  end
end
