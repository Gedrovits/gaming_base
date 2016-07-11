module LoggedAction
  extend ActiveSupport::Concern
  
  included do
    around_action :logged_action
    
    # Adds tag around log of action
    def logged_action
      label = "#{controller_name}##{action_name}"
      logger.tagged(label) do
        logger.info { '-> Started' }
        yield
        logger.info { '-> Finished' }
      end
    end
  end
end
