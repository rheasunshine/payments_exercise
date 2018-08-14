class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :loan, foreign_key: true
      t.datetime :payment_date
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
