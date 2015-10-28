class Player < ActiveRecord::Base
  validates_presence_of :team_id, :first_name, :last_name , :dob , :debut

  #A - Player belong to team as player always associate to a team.
  belongs_to :team
  #A - Player belong to a coach as coach can only create a player for a team.
  belongs_to :coach
end
