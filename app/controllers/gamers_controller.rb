class GamersController < ApplicationController
  def index
    @gamers = Gamer.all
  end
  
  def show
    @gamer = Gamer.friendly.find(params[:id])
  end
  
  def edit
    @gamer = Gamer.friendly.find(params[:id])
    
    render 'form'
  end
  
  def update
    @gamer = Gamer.friendly.find(params[:id])
    
    if @gamer.update_attributes(gamer_params)
      redirect_to gamer_path(@gamer)
    else
      render 'form'
    end
  end
  
  def home
    @communities = current_gamer.communities
    @teams       = current_gamer.teams
  end
  
  def lets_play
  end
  
  def organize
  end
  
  def explore
  end
  
  # GET /gamer
  def gamer
    @gamer = current_user.gamer
    
    render 'form'
  end
  
  # POST /update_gamer
  def update_gamer
    @gamer = current_user.gamer
    
    if @gamer.update_attributes(gamer_path)
      redirect_to user_gamer_path
    else
      render 'form'
    end
  end
  
  def search
    @filters = OpenStruct.new
    # Set smart defaults from current gamer...
    # if current_gamer.age
    #   @filters.min_age = current_gamer.age - 5
    #   @filters.max_age = current_gamer.age + 5
    # end
    
    # @filters.languages = current_gamer.data.dig('languages')
    
    @filters.swearing_tolerance = current_gamer.swearing_tolerance
    
    # @filters.teams = current_user.team_ids
    # @filters.communities = current_user.community_ids
  end
  
  def search_results
    @page = params[:page] ||= 1
    
    # TODO: Later this can be object Filters
    @filters = OpenStruct.new(params[:filters])
    
    @games = @filters.dig(:games)&.reject(&:blank?)
    @teams = @filters.dig(:teams)&.reject(&:blank?)
    @communities = @filters.dig(:communities)&.reject(&:blank?)
    @sex = @filters.dig(:sex)&.reject(&:blank?)
    
    q = Gamer.where.not(id: current_gamer.id) # Do not show self
    
    # Privacy filtering
    # We need memberships for privacy settings
    q = q.joins(:memberships)
    q = q.merge(Membership.privacy_filter(current_gamer.id, current_gamer.team_ids, current_gamer.community_ids))
    
    # Age
    age_range = @filters.min_age..@filters.max_age unless @filters.min_age.blank? && @filters.max_age.blank?
    q = q.where(age: age_range) unless age_range.blank?
    # Sex
    q = q.where(sex: @sex) unless @sex.blank?
    # Swearing
    q = q.where(swearing: @filters.swearing_tolerance) unless @filters.swearing_tolerance.blank?
    
    # Games filters
    q = q.joins(:games).where(games: { id: @games }) unless @games.blank?
    # Teams filters
    q = q.joins(:teams).where(teams: { id: @teams }) unless @teams.blank?
    # Communities filters
    q = q.joins(:communities).where(communities: { id: @communities }) unless @communities.blank?
    # print q.to_sql
    @gamers = q.page(@page).per(15)
    
    render 'search'
  end
  
  private
  
  def gamer_params
    params.require(:gamer).permit! # FIXME
  end
  
  def arel
    Gamer.arel_table
  end
end
