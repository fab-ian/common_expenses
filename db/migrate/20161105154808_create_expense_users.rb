class CreateExpenseUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :expense_users do |t|
      t.references :expense, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
