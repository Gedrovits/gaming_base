class SettingsController < ApplicationController
  def gamer
    @gamer = current_gamer
  end
  
  def update_gamer
    @gamer = current_user.gamer
  
    if @gamer.update_attributes(gamer_params)
      redirect_back(fallback_location: root_path)
    else
      render action: :gamer
    end
  end
  
  def user
    @user = current_user
  end
  
  def update_user
    @user = current_user
  
    if @user.update_attributes(user_params)
      redirect_back(fallback_location: root_path)
    else
      render action: :user
    end
  end
  
  def identities
    @identities = current_user.identities
  end
  
  private
  
  def gamer_params
    params.require(:gamer).permit(:username, :dedication, :weekday_availability, :weekend_availability, 
                                  :swearing, :swearing_tolerance, :privacy, :description, 
                                  :first_name, :middle_name, :last_name, :birth_date, :sex, :age, game_ids: [])
  end
  
  def user_params
    params.require(:user).permit(:locale, :time_zone)
  end
end
