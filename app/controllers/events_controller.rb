class EventsController < ApplicationController
  def index
    @events = policy_scope(Event)
  end
  
  def show
    @event = Event.find(params[:id])
    authorize @event
  end
  
  def new
    @event = Event.new
    @event.event_games.build
    @event.event_participation.build
    authorize @event
    
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
    authorize @event
    
    render 'form'
  end
  
  def update
    @event = Event.find(params[:id])
    authorize @event
    
    if @event.update_attributes(event_params)
      redirect_to events_path
    else
      render 'form'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    authorize @event
    
    if @event.destroy
      redirect_to events_path
    else
      redirect_to :back, alert: 'Destroy failed'
    end
  end
  
  def change_participation
    @event_participation = EventParticipation.find(params[:id])
    authorize @event_participation, :update?
    
    if @event_participation.update(event_participation_params)
      flash.notice = 'Success'
    else
      flash.alert = 'Failure'
    end

    redirect_back(fallback_location: events_path)
  end
  
  private
  
  def event_params
    params.require(:event).permit! # TODO: Fix this
  end
  
  def event_participation_params
    params.require(:event_participation).permit! # TODO: Fix this
  end
  
  def arel
    Event.arel_table
  end
end
