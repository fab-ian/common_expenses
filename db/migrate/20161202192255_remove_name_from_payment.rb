class RemoveNameFromPayment < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :name, :string
  end
end
