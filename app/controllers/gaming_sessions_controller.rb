class GamingSessionsController < ApplicationController
  def index
    @gaming_sessions = GamingSession.all
  end
  
  def show
    @gaming_session = GamingSession.find(params[:id])
  end
  
  def new
    @gaming_session = GamingSession.new
    
    render 'form'
  end
  
  def create
    @gaming_session = GamingSession.new(gaming_session_params)
    
    if @gaming_session.save
      redirect_to gaming_sessions_path
    else
      render 'form'
    end
  end
  
  def edit
    @gaming_session = GamingSession.find(params[:id])
    
    render 'form'
  end
  
  def update
    @gaming_session = GamingSession.find(params[:id])
    
    if @gaming_session.update_attributes(gaming_session_params)
      redirect_to gaming_sessions_path
    else
      render 'form'
    end
  end
  
  def destroy
    @gaming_session = GamingSession.find(params[:id])
    
    if @gaming_session.destroy
      redirect_to gaming_sessions_path
    else
      redirect_to :back, alert: 'Destroy failed'
    end
  end
  
  private
  
  def gaming_session_params
    params.require(:gaming_session).permit! # TODO: Fix this
  end
  
  def arel
    GamingSession.arel_table
  end
end
