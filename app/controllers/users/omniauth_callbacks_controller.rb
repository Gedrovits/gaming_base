class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # [:facebook, :twitter, :google_oauth2, :github, :twitch, :steam]
  
  skip_before_filter :verify_authenticity_token, only: :steam # FIXME: Steam sending request, which don't have auth token...
  
  def facebook
  end
  
  def twitter
  end
  
  def google_oauth2
  end
  
  def github
  end
  
  def twitch
  end
  
  def steam
  end
  
  # FIXME: Refactor all the shit below
  
  def self.human_readable_provider_name(provider)
    case provider
    when :facebook, :twitter, :twitch, :steam then provider.capitalize
    when :google_oauth2 then 'Google'
    when :github then 'GitHub'
    else
      'Unknown'
    end
  end
  
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{human_readable_provider_name(provider)}") if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end
  
  [:facebook, :twitter, :google_oauth2, :github, :twitch, :steam].each do |provider|
    provides_callback_for provider
  end
  
  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      # finish_signup_path(resource)
      super resource
    end
  end
end
