class Coach < User
  #A - here we are associating relation between models. 


  #A - Coach can have more then one teams.
  has_many :teams, :dependent => :destroy
  #A - Coach can have more then one leagues.
  has_many :leagues, :dependent => :destroy
end
