class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members, primary_key: :member_id do |t|
      t.bigint :group_id, null: false
      t.string :member_name, null: false

      t.timestamps
    end
    add_foreign_key :members, :groups, column: :group_id, primary_key: :group_id
  end
end
