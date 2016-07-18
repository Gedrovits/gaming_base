class GamesController < ApplicationController
  def index
    @games = Game
    @games = @games.where(arel[:name].matches("%#{params[:name]}%")
                            .or(arel[:abbreviation].matches("%#{params[:name]}%"))) unless params[:name].blank?
    @games = @games.all
  end
  
  def show
    @game = Game.friendly.find(params[:id])
  end
  
  def new
    @game = Game.new
    
    render 'form'
  end
  
  def create
    @game = Game.new(game_params)
    
    if @game.save
      redirect_to games_path
    else
      render 'form'
    end
  end
  
  def edit
    @game = Game.friendly.find(params[:id])
    
    render 'form'
  end
  
  def update
    @game = Game.friendly.find(params[:id])
    
    if @game.update_attributes(game_params)
      redirect_to games_path
    else
      render 'form'
    end
  end
  
  def destroy
    @game = Game.friendly.find(params[:id])
    
    if @game.destroy
      redirect_to games_path
    else
      redirect_to :back, alert: 'Destroy failed'
    end
  end
  
  private
  
  def game_params
    params.require(:game).permit(:name, :abbreviation, :active)
  end
  
  def arel
    Game.arel_table
  end
end
