class EventsController < ApplicationController
  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
    @event.event_games.build
    @event.event_participation.build
    
    render 'form'
  end
  
  def create
    @event = Event.new(event_params.merge(gamer: current_gamer))
    
    if @event.save
      redirect_to events_path
    else
      render 'form'
    end
  end
  
  def edit
    @event = Event.find(params[:id])
    
    render 'form'
  end
  
  def update
    @event = Event.find(params[:id])
    
    if @event.update_attributes(event_params)
      redirect_to events_path
    else
      render 'form'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    
    if @event.destroy
      redirect_to events_path
    else
      redirect_to :back, alert: 'Destroy failed'
    end
  end
  
  private
  
  def event_params
    params.require(:event).permit! # TODO: Fix this
  end
  
  def arel
    Event.arel_table
  end
end
