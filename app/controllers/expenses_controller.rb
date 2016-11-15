class ExpensesController < ApplicationController
  expose :expense
  expose :item_users, -> { ItemUser.get_participants(expense_params[:item_id]) }

  def create
    ActiveRecord::Base.transaction do
      expense.save

      users_ids = item_users.pluck(:user_id)
      insert_sql = ExpenseUser.inserts(users_ids, expense)

      sql = "INSERT INTO expense_users (\"expense_id\", \"user_id\", \"created_at\", \"updated_at\")
       VALUES #{insert_sql.join(', ')}"

      ActiveRecord::Base.connection.execute sql
    end

    redirect_to item_path(expense_params[:item_id])
  end

  def destroy
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :item_id)
  end
end
