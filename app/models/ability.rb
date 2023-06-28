class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    else
      can :read, Post
      can :create, Post if user.signed_in?
      can :update, Post, user_id: user.id
      can :destroy, Post, user_id: user.id

      can :destroy, Comment, user_id: user.id
    end
  end
end
