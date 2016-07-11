class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  
  def homepage
  end
  
  def about
  end
  
  def partners
  end
  
  def developers
  end
  
  def terms_of_service
  end
  
  def privacy_policy
  end
  
  def cookie_policy
  end
  
  def kitchensink
  end
end