class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :payment_user_id,   null: false
      t.integer :receiving_user_id, null: false
      t.integer :amount,            null: false

      t.timestamps
    end
  end
end
