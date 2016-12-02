class PaymentsController < ApplicationController
  expose :payment

  def create
    payment.save
    @e = payment.expense
    render :create_update
  end

  def update
    payment.update(payment_params)
    @e = payment.expense
    render :create_update
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :user_id, :item_id, :expense_id)
  end
end
