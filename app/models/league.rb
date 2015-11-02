class League < ActiveRecord::Base
  #A - This is for validation of form. When we save form we check presence of follwoing attributes value in form. Else validation error show on page.
  validates_presence_of :title
  validates :division_1,:division_2,:division_3,:division_4,:division_5, presence: true, numericality: { greater_than: 0 }
  #A - League belong to coach because caoch created it. 
  belongs_to :coach
  #A - League can have more than one team.
  has_many :teams, :dependent => :destroy
  validates_uniqueness_of :title
end
