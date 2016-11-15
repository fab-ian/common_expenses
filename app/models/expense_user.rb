class ExpenseUser < ApplicationRecord
  belongs_to :expense, counter_cache: :number_of_participants
  belongs_to :user

  scope :get_participants, ->(expense_id) { includes(:user).where(expense_id: expense_id) }

  def self.inserts(users_id, expense)
    inserts = []
    expense_id = expense.id

    users_id.each do |u_id|
      inserts.push("(#{expense_id}, #{u_id}, '#{Time.now}', '#{Time.now}' )")
    end
    inserts
  end
end
