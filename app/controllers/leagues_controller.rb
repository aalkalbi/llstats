class LeaguesController < ApplicationController
  before_action :check_authorization!
  before_action :check_if_coach!
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  # GET /leagues
  # GET /leagues.json
  #A - Index page to list all the Leagues created by a coach.
  def index
    @leagues = League.all
  end

  # GET /leagues/1
  # GET /leagues/1.json
  #A - Show a single league detail after league created. The Show button on index page of league.
  def show
  end

  # GET /leagues/new
  #A - Create a new league. The new page where we create a league.
  def new
    @league = League.new
  end

  # GET /leagues/1/edit
  #A - Edit a created league. The Edit page of a league.
  def edit
  end

  # POST /leagues
  # POST /leagues.json
  #A - Create a league. The new page sends a request to create the league.
  def create
    @league = League.new(league_params)

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render :show, status: :created, location: @league }
      else
        format.html { render :new }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  #A - Update a league request. Edit page sends request to update a league.
  def update
    respond_to do |format|
      if @league.update(league_params)
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { render :show, status: :ok, location: @league }
      else
        format.html { render :edit }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  #A - Destroy the League with all associted dependencies like Team and Players.
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to leagues_url, notice: 'League was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #A - A setter method to to set league.
    def set_league
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #A - Only allow mentioned parameters to come to the controller otherwise raise a exception and not save not allowed parameters. 
    def league_params
      params.require(:league).permit(:title, :description, :division_1, :division_2, :division_3, :division_4, :division_5,:coach_id)
    end
end
