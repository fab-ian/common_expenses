class ItemUsersController < ApplicationController
  expose :item_user

  def create
    item_user.save
  end

  def destroy
    item_user.destroy
  end

  private

  def item_user_params
    params.require(:item_user).permit(:item_id, :user_id)
  end
end
