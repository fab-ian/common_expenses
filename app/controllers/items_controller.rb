class ItemsController < ApplicationController
  expose :items, -> { Item.all }
  expose :item
  expose :item_user, -> { ItemUser.new }
  expose :item_users, -> { ItemUser.get_participants(params[:id]) }
  expose :expense
  expose :expenses, -> { Expense.where(item_id: params[:id]) }
  expose :expense_user, -> { ExpenseUser.new }

  def create
    if item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def update
    if item.update(item_params)
      redirect_to item_path(item.id)
    else
      render :edit
    end
  end

  def destroy
    item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description).merge(user_id: current_user.id)
  end
end
