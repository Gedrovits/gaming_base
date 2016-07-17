class IdentitiesController < ApplicationController
  def index
    @identities = policy_scope(Identity)
  end
  
  def show
    @identity = Identity.find(params[:id])
  end
end
