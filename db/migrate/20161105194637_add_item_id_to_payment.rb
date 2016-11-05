class AddItemIdToPayment < ActiveRecord::Migration[5.0]
  def change
    add_reference :payments, :item, foreign_key: true
  end
end
