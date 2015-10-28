class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  #A - Index page to list all the Teams created by a coach.
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  #A - Show a single team detail after team created. The Show button on index page of team.
  def show
  end

  # GET /teams/new
  #A - Create a new team. The new page where we create a team.
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  #A - Edit a created team. The Edit page of a team.
  def edit
  end

  # POST /teams
  # POST /teams.json
  #A - Create a team. The new page sends a request to create the team.
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  #A - Update a team request. Edit page sends request to update a team.
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  #A - Destroy the team with all associted depencies.Here team has dependency players. If team deleted the players also get deleted.
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #A - A setter method to to set team.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #A - Only allow mentioned parameters to come to the controller otherwise raise a exception and not save not allowed parameters. 
    def team_params
      params.require(:team).permit(:name, :division, :location, :debut,:coach_id,:league_id)
    end
end
