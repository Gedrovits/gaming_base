class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    #= Load some required variables
    gamer = user.gamer
    team_ids = gamer.team_ids
    community_ids = gamer.community_ids
    membership_ids = gamer.membership_ids
  
    #= Authorizations
    can :manage, :all if user.is_core?
  
    # Can manage own user
    can :manage, User, id: user.id
    # Can manage own identities
    can :manage, Identity, user_id: user.id
    
    #= Gamers
    can :manage, Gamer, id: gamer.id
    can :read, Gamer # Can read other gamers
    
    #= Communities
    can :manage, Community, { id: community_ids } # Can manager own communities
    can :read, Community # Can read other communities
    # Advanced memberships conditions
    can :join, Community
  
    #= Teams
    can :manage, Team, { id: team_ids } # Can manage own teams
    can :read, Team # Can read other teams
    # Advanced memberships conditions
    can :join, Team
  
    #= Memberships
    # FIXME: Allow perform action on members by permissions and roles
    can :manage, Membership, { id: membership_ids } # Can manage own memberships
  end
end
