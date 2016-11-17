class CalculatorsController < ApplicationController
  def calculate_amounts
    c = CalculatorService.new
    @calculated_result = c.calculate_common_expenses(params[:item_id])
  end
end
