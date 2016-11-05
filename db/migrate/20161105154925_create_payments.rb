class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.text :description
      t.decimal :amount

      t.timestamps
    end
  end
end
