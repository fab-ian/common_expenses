class AddExpenseToPayment < ActiveRecord::Migration[5.0]
  def change
    add_reference :payments, :expense, foreign_key: true
  end
end
