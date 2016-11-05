class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.references :item, foreign_key: true
      t.string :name
      t.decimal :amount
      t.integer :number_of_participants

      t.timestamps
    end
  end
end
