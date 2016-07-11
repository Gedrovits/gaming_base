require 'active_support/concern'

module Crudable
  extend ActiveSupport::Concern
  
  included do
    def index
      instance_variable_set("@#{klass.table_name}", klass.all)
      
      respond_to do |format|
        format.html
        format.json { render json: instance_variable_get("@#{klass.table_name}")  }
        format.xml  { render xml: instance_variable_get("@#{klass.table_name}") }
      end
    end
    
    def show
      instance_variable_set("@#{klass_singular_variable}", klass.find(params[:id]))
      
      respond_to do |format|
        format.html
        format.json { render json: instance_variable_get("@#{klass_singular_variable}") }
        format.xml  { render xml: instance_variable_get("@#{klass_singular_variable}") }
      end
    end
    
    def new
      instance_variable_set("@#{klass_singular_variable}", klass.new)
      
      respond_to do |format|
        format.html { render 'form' }
        format.json { render json: instance_variable_get("@#{klass_singular_variable}") }
        format.xml  { render xml: instance_variable_get("@#{klass_singular_variable}") }
      end
    end
    
    def create
      instance_variable_set("@#{klass_singular_variable}", klass.new(send("#{klass_singular_variable}_params")))
      
      respond_to do |format|
        if instance_variable_get("@#{klass_singular_variable}").save
          format.html { redirect_to({ action: :index }) }
          format.json { render json: instance_variable_get("@#{klass_singular_variable}"), status: :created, location: instance_variable_get("@#{klass_singular_variable}") }
          format.xml  { render xml: instance_variable_get("@#{klass_singular_variable}"), status: :created, location: instance_variable_get("@#{klass_singular_variable}") }
        else
          format.html { render 'form' }
          format.json { render json: instance_variable_get("@#{klass_singular_variable}").errors, status: :unprocessable_entity }
          format.json { render xml: instance_variable_get("@#{klass_singular_variable}").errors, status: :unprocessable_entity }
        end
      end
    end
    
    def edit
      instance_variable_set("@#{klass_singular_variable}", klass.find(params[:id]))
      
      respond_to do |format|
        format.html { render 'form' }
        format.json { render json: instance_variable_get("@#{klass_singular_variable}") }
        format.xml  { render xml: instance_variable_get("@#{klass_singular_variable}") }
      end
    end
    
    def update
      instance_variable_set("@#{klass_singular_variable}", klass.find(params[:id]))
      
      respond_to do |format|
        if instance_variable_get("@#{klass_singular_variable}").update(send("#{klass_singular_variable}_params"))
          format.html { redirect_to({ action: :index }) }
          format.json { head :ok }
          format.xml  { head :ok }
        else
          format.html { render 'form' }
          format.json { render json: instance_variable_get("@#{klass_singular_variable}").errors, status: :unprocessable_entity }
          format.json { render xml: instance_variable_get("@#{klass_singular_variable}").errors, status: :unprocessable_entity }
        end
      end
    end
    
    def destroy
      instance_variable_set("@#{klass_singular_variable}", klass.find(params[:id]))
      
      if instance_variable_get("@#{klass_singular_variable}").destroy
        flash[:notice] = 'Successfully deleted.'
      else
        flash[:error] = 'Delete failed.'
      end
      
      respond_to do |format|
        if instance_variable_get("@#{klass_singular_variable}").destroy
          format.html { redirect_to(:back) }
          format.json { head :ok }
          format.xml  { head :ok }
        else
        
        end
      end
    end
    
    private
    
    def klass
      controller_name.classify.constantize
    end
    
    def klass_singular_variable
      klass.to_s.downcase.freeze
    end
    
    define_method "#{klass_singular_variable}_params" do
      logger.warn "TODO: Please configure this in included controller."
      params.require("#{klass_singular_variable}".to_sym).permit!
    end
  end
  
  class_methods do
    def klass
      controller_name.classify.constantize
    end
    
    def klass_singular_variable
      klass.to_s.downcase.freeze
    end
  end
end
