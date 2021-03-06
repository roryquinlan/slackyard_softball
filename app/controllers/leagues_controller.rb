class LeaguesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @leagues = League.order("updated_at DESC").take(3)
  end

  def show
    @league = League.find(params[:id])
    @standings = @league.standings
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.commissioner_id = current_user.id if current_user

    if @league.save
      flash[:notice] = "Your league '#{@league.name}' has been created!"
      redirect_to league_path(@league)
    else
      flash.now[:notice] = "Your league could not be created!"
      render :new
    end
  end

  def edit
    @league = League.find(params[:id])
    @managers = []
    @league.teams.each { |team| @managers << team.user }
  end

  def update
    @league = League.find(params[:id])

    if commissioner?
      @league.update(league_params)
      flash[:notice] = "#{@league.name} has been successfully updated!"
      redirect_to league_path(@league)
    end
  end

  def destroy
    @league = League.find(params[:id])

    if commissioner?
      @league.destroy

      flash[:notice] = "#{@league.name} has been permanently shut down."
      redirect_to leagues_path
    end
  end

  def commissioner?
    current_user == @league.commissioner
  end

  private

  def league_params
    params.require(:league).permit(:name, :commissioner_id)
  end

end
