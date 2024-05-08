class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups, primary_key: :group_id do |t|
      t.string :group_name, null: false
      t.string :token

      t.timestamps
    end
  end
end
