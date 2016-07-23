class API::GamersController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: "gamingbase", password: "qwerty"
  
  def index
    if params[:pg]
      render plain: execute("SELECT array_to_json(array_agg(gamers)) as result FROM gamers")
    elsif params[:arel]
      gamers = Gamer.arel_table
      # q = gamers.project("array_to_json(array_agg(gamers)) as result")
      q = gamers.project(array_to_json([array_agg([gamers])], 'result'))
      # q = q.where(gamers[:username].eq('Balls'))
      render json: execute(q.to_sql)
    else
      render json: Gamer.all
    end
  end
  
  def execute(sql)
    ApplicationRecord.connection.execute(sql)[0]['result']
  end
  
  private

  def array_to_json(contents, as = nil)
    Arel::Nodes::NamedFunction.new("array_to_json", contents, as)
  end
  
  def array_agg(contents, as = nil)
    Arel::Nodes::NamedFunction.new("array_agg", contents, as)
  end
end
