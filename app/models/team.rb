class Team < ActiveRecord::Base
  #A - Team belong to a coach as coach only create a team.
  belongs_to :coach
  #A - Team belong to league as team is always associated with a league.
  belongs_to :league
  #A - a team can have more than one player.
  has_many :players, :dependent => :destroy
  #A - Check validation while creating a team. Team must have following attributes present while creation else throw a validation error.
  validates_presence_of :league_id,:name,:division,:location

#A - To show dropdown of Division on team creation page.
  DIVISION = {"Little League Major" => "division_1","Junior League"=> "division_2","Senior League"=> "division_3","Big League"=> "division_4","Challenger League"=> "division_5"}
end
