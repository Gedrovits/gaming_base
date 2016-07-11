class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all
  end
  
  def show
    @membership = Membership.find(params[:id])
  end
  
  def new
    @membership = Membership.new
    
    render 'form'
  end
  
  def create
    @membership = Membership.new(membership_params)
    
    if @membership.save
      redirect_to membership_path(@membership)
    else
      render 'form'
    end
  end
  
  def edit
    @membership = Membership.find(params[:id])
    
    render 'form'
  end
  
  def update
    @membership = Membership.find(params[:id])
    
    if @membership.update_attributes(membership_params)
      redirect_to membership_path(@membership)
    else
      render 'form'
    end
  end
  
  def destroy
    @membership = Membership.find(params[:id])
    
    if @membership.destroy
      redirect_to memberships_path
    else
      redirect_to :back, alert: 'Destroy failed'
    end
  end
  
  # = Non-CRUD
  
  # FIXME: Refactor this
  def approve
    @membership = Membership.find(params[:id])
    @membership.update_attribute(:status, :approved)
    
    redirect_to :back
  end
  
  # FIXME: Refactor this
  def decline
    @membership = Membership.find(params[:id])
    @membership.update_attribute(:status, :declined)
    
    redirect_to :back
  end
  
  # FIXME: Refactor this
  def ban
    @membership = Membership.find(params[:id])
    @membership.update_attribute(:status, :banned)
    
    redirect_to :back
  end
  
  # FIXME: Refactor this
  def unban
    @membership = Membership.find(params[:id])
    @membership.update_attribute(:status, :pending)
    
    redirect_to :back
  end
  
  # FIXME: Refactor this
  def change_role
    @membership = Membership.find(params[:id])
    @membership.update_attribute(:role_id, params[:role_id])
    
    redirect_to :back
  end
  
  private
  
  def membership_params
    params.require(:membership).permit! # FIXME
  end
  
  def arel
    Membership.arel_table
  end
end
