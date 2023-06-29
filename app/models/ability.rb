class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Define abilities for the different user roles
    if user.role == 'admin'
      can :manage, :all
    else
      can :manage, Comment, user_id: user.id
      can :create, [Post, Comment]
      can :read, [Post, Comment]
      can %i[update destroy], Post, user_id: user.id
    end
  end
end
