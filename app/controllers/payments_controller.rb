class PaymentsController < ApplicationController
  expose :payment

  def create
    render :error unless payment.save
  end

  def destroy
  end

  private

  def payment_params
    params.require(:payment).permit(:name, :description, :amount, :user_id, :item_id)
  end
end
