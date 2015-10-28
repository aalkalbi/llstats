class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :division
      t.string :location
      t.string :debut
      t.references :league

      t.timestamps null: false
    end
  end
end
