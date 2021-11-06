class CreateOrders < ActiveRecord::Migration[5.2]
  
  def change
    create_table :orders do |t|
      
    t.references :customer, null: false
    t.string :postal_code, null: false
    t.string :address, null: false
    t.string :name, null: false
    t.integer :shipping_cost, null: false
    t.integer :total_payment, null: false
    t.integer :payment_method, null: false
    t.integer :status, null: false
    t.datetime :created_at,null: false
    t.datetime :updated_at,null: false

      t.timestamps
    end
  end
end
