class IdentitiesController < ApplicationController
  load_and_authorize_resource :identity
  
  def index
    @identities = Identity.all
  end
  
  def show
    @identity = Identity.find(params[:id])
  end

end
