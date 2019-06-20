class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :type
      t.date :trans_date
      t.decimal :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
