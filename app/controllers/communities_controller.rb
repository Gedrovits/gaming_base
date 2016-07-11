class CommunitiesController < ApplicationController
  load_and_authorize_resource :community, except: [:join, :leave]
  
  def index
    # @communities = Community
    @communities = @communities.where(arel[:name].matches("%#{params[:name]}%")) unless params[:name].blank?
    @communities = @communities.all
  end
  
  def show
    @community = Community.friendly.find(params[:id])
  end
  
  def new
    @community = Community.new
    
    render 'form'
  end
  
  def create
    @community = Community.new(community_params)
    founder_role = Role.find_by_abbreviation('FNDR')
    
    @community.memberships.build(type: :gamer_in_community,
                                 gamer: current_gamer, role: founder_role,
                                 status: :approved)
    
    if @community.save
      redirect_to @community
    else
      render 'form'
    end
  end
  
  def edit
    @community = Community.friendly.find(params[:id])
    
    render 'form'
  end
  
  def update
    @community = Community.friendly.find(params[:id])
    
    if @community.update_attributes(community_params)
      redirect_to communities_path
    else
      render 'form'
    end
  end
  
  def destroy
    @community = Community.friendly.find(params[:id])
    
    if @community.destroy
      redirect_to communities_path
    else
      redirect_to :back, alert: 'Destroy failed'
    end
  end
  
  #= Non-CRUD
  
  def join
    @community = Community.friendly.find(params[:id])
    
    if current_membership
      current_membership.update_attribute(:status, :pending)
    else
      member_role = Role.find_by_abbreviation('MMBR')
      @community.memberships.build(type: :gamer_in_community,
                                   gamer: current_gamer,
                                   role: member_role,
                                   status: :pending)
      @community.save
    end
    
    redirect_to @community
  end
  
  def leave
    @community = Community.friendly.find(params[:id])
    
    current_membership.update_attribute(:status, :left)
    
    redirect_to @community
  end
  
  private
  
  def community_params
    params.require(:community).permit! # TODO: Fix this
  end
  
  def current_membership
    @current_membership ||= current_gamer.memberships.for_community(@community).first
  end
  
  def arel
    Community.arel_table
  end
end
