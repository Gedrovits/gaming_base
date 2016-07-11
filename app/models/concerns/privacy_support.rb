require 'active_support/concern'

module PrivacySupport
  extend ActiveSupport::Concern
  
  included do
    enum privacy: {
      anyone: 100,
      team_or_community: 200,
      community_only: 300,
      team_only: 400,
      me_only: 500
    }, _prefix: true
  end
end
