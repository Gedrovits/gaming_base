class UsersController < ApplicationController
  load_and_authorize_resource :user
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
    
    render 'form'
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to users_path
    else
      render 'form'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    
    render 'form'
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render 'form'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    
    if @user.destroy
      redirect_to users_path
    else
      redirect_to :back, alert: 'Destroy failed'
    end
  end
  
  # Core Only Mega Actions
  
  def become_user
    allowed = if current_user.is_core?
                session[:became_user]  = true            unless session[:became_user]
                session[:superuser_id] = current_user.id unless session[:superuser_id]
                become_user = User.find(params[:id])
                sign_in(:user, become_user)
                flash[:notice] = "You are logged in as #{become_user.gamer.to_label}"
                true
              else
                false
              end
    
    respond_to do |format|
      if allowed
        format.html { redirect_to root_path }
      else
        format.html { render_404 }
      end
    end
  end
  
  def become_self
    allowed = if session[:became_user] && session[:superuser_id]
                sign_in(:user, User.find(session[:superuser_id]))
                session[:became_user]  = nil
                session[:superuser_id] = nil
                flash[:notice] = 'You are logged in as yourself'
                true
              else
                false
              end
    
    respond_to do |format|
      if allowed
        format.html { redirect_to root_path }
      else
        format.html { render_404 }
      end
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit! # FIXME
  end
  
  def arel
    User.arel_table
  end
end
