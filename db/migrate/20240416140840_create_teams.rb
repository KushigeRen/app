class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams, primary_key: :team_id do |t|
      t.string :team_name, null: false

      t.timestamps
    end
  end
end
