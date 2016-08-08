class ApplicationController < ActionController::Base
  include LoggedAction
  include Pundit
  # after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :set_locale
  around_action :set_time_zone
  
  def set_locale
    I18n.locale = if params[:hl]
                    params[:hl]
                  elsif user_signed_in?
                    current_user.locale
                  else
                    I18n.default_locale
                  end
  end
  
  def set_time_zone
    if user_signed_in?
      Time.use_zone(current_user.time_zone) { yield }
    else
      yield
    end
  end
  
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end
  
  helper_method :current_gamer
  helper_method :current_membership
  
  private
  
  def current_gamer
    @current_gamer ||= current_user.gamer if current_user
  end
  
  def current_membership
    @current_membership = nil
  end
end
