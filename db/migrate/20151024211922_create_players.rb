class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :dob
      t.string :debut
      t.string :height
      t.string :weight
      t.integer :coach_id
      t.string :postal_code
      t.integer :rank
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
