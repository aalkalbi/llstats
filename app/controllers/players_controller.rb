class PlayersController < ApplicationController
  before_action :check_authorization!
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  #A - Index page to list all the Players created by a coach.
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  #A - Show a single player detail after player created. The Show button on index page of player.
  def show
  end

  # GET /players/new
  #A - Create a new player. The new page where we create a player.
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  #A - Edit a created player. The Edit page of a player.
  def edit
  end

  # POST /players
  # POST /players.json
  #A - Create a player. The new page sends a request to create the player.
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  #A - Update a player request. Edit page sends request to update a player.
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  #A - Destroy the player with all associted depencies.Here currently no dependencies associted with Player.In future we will have stats as dependency.
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #A - A setter method to to set player.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #A - Only allow mentioned parameters to come to the controller otherwise raise a exception and not save not allowed parameters. 
    def player_params
      params.require(:player).permit(:first_name, :last_name, :dob, :debut, :height, :weight, :coach_id, :postal_code, :rank, :team_id)
    end
end
