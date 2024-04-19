class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members, primary_key: :member_id do |t|
      t.bigint :team_id, null: false
      t.string :member_name, null: false

      t.timestamps
    end
    add_foreign_key :members, :teams, column: :team_id, primary_key: :team_id
  end
end
