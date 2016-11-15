class ExpenseUsersController < ApplicationController
  expose :expense_user

  def create
    expense_user.save
  end

  def destroy
    expense_user.destroy
  end

  private

  def expense_user_params
    params.require(:expense_user).permit(:expense_id, :user_id)
  end
end
