class TeamsController < ApplicationController
  load_and_authorize_resource :team, except: [:join, :leave] # FIXME
  
  def index
    # @teams = Team.all
    @teams = @teams.where(arel[:name].matches("%#{params[:name]}%")) unless params[:name].blank?
    @teams = @teams.all
  end
  
  def show
    @team = Team.friendly.find(params[:id])
  end
  
  def new
    @team = Team.new
    
    render 'form'
  end
  
  def create
    @team = Team.new(team_params)
    founder_role = Role.find_by_abbreviation('FNDR')
    @team.memberships.build(type: :gamer_in_team, gamer: current_gamer,
                            role: founder_role, status: :approved)
    
    if @team.save
      redirect_to @team
    else
      render 'form'
    end
  end
  
  def edit
    @team = Team.friendly.find(params[:id])
    
    render 'form'
  end
  
  def update
    @team = Team.friendly.find(params[:id])
    
    if @team.update_attributes(team_params)
      redirect_to team_path
    else
      render 'form'
    end
  end
  
  def destroy
    @team = Team.friendly.find(params[:id])
    
    if @team.destroy
      redirect_to team_path
    else
      redirect_to :back, alert: 'Destroy failed'
    end
  end
  
  # = Non-CRUD
  
  def join
    @team = Team.friendly.find(params[:id])
    
    if current_membership
      current_membership.update_attribute(:status, :pending)
    else
      member_role = Role.find_by_abbreviation('MMBR')
      @team.memberships.build(type: :gamer_in_team, gamer: current_gamer,
                              role: member_role, status: :pending)
      @team.save
    end
    
    redirect_to @team
  end
  
  def leave
    @team = Team.friendly.find(params[:id])
    
    current_membership.update_attribute(:status, :left)
    
    redirect_to @team
  end
  
  private
  
  def team_params
    params.require(:team).permit! # FIXME
  end
  
  def current_membership
    @current_membership ||= current_gamer.memberships.for_team(@team).first
  end
  
  def arel
    Team.arel_table
  end
end
