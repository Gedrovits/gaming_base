module Middleware
  class HiddenApi
    attr_reader :app, :options
    
    def initialize(app, options = {})
      @app, @options = app, options
    end
    
    def call(env)
      request = Rack::Request.new(env)
      
      safe_ips = ['::1', '84.52.11.62']
      return @app.call(env) if !safe_ips.include?(request.ip) && !request.path.include?('/hidden_api')
      
      # Handle Hidden API calls
      case request.path
      when '/hidden_api/games' then json_response(Game.all.to_json)
      when '/hidden_api/gamers' then json_response(Gamer.all.to_json)
      end
    end
    
    private
    
    def json_response(content)
      [200, {'Content-Type' => 'text/json'}, [content]]
    end
  end
end
