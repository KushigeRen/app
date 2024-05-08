class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments, primary_key: :payment_id do |t|
      t.bigint :creditor_member_id, null:false
      t.bigint :debtor_member_id, null:false
      t.bigint :group_id, null:false
      t.integer :amount, null:false
      t.date :payment_date, null:false
      t.date :payment_deadline
      t.string :description, null:false

      t.timestamps
    end
    add_foreign_key :payments, :members, column: :creditor_member_id, primary_key: :member_id
    add_foreign_key :payments, :members, column: :debtor_member_id, primary_key: :member_id
  end
end
