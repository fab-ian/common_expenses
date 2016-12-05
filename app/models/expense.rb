class Expense < ApplicationRecord
  belongs_to :item
  has_many :expense_users, dependent: :destroy
  has_one :payment, dependent: :destroy

  validates :name, :amount, presence: true

  after_update :update_payment_amount

  scope :not_paid, (lambda do |item_id|
    where(item_id: item_id).where.not(id: Payment.where(item_id: item_id).pluck(:expense_id))
  end)

  def update_payment_amount
    payment.update(amount: amount)
  end
end
