class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :title
      t.string :description
      t.integer :division_1
      t.integer :division_2
      t.integer :division_3
      t.integer :division_4
      t.integer :division_5

      t.timestamps null: false
    end
  end
end
