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
  
    gamer = user.gamer
  
    # Authorizations
    can :manage, :all if user.is_core?
  
    can :manage, User, id: user.id
  
    # Can manage own identities
    can :manage, Identity, user_id: user.id
  
    # Can see public gamers
    # Can manage himself
    can :manage, Gamer, id: gamer.id
  
    # Can see own memberships
    # Can see if team have public mode
    # Can't see if team have private mode
    can :manage, Community #, gamers: { id: gamer.id }
    can :manage, Team #, gamers: { id: gamer.id }
  
    can :manage, Membership # FIXME :)

    # Can see own participations
    # Can see own events
    # Can see team events (through participations?)
    # Can see community events (through participations?)
  end
end
