class RemoveDescriptionFromPayment < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :description, :text
  end
end
