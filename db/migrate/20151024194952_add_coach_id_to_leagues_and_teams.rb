class AddCoachIdToLeaguesAndTeams < ActiveRecord::Migration
  def change
   add_column :leagues, :coach_id, :integer
   add_column :teams, :coach_id, :integer
  end
end
