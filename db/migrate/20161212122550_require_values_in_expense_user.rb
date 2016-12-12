class RequireValuesInExpenseUser < ActiveRecord::Migration[5.0]
  def change
    change_column_null :expense_users, :user_id, false
    change_column_null :expense_users, :expense_id, false
  end
end
