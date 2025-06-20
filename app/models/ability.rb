class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 

    if user.role == 'admin'
      can :manage, :all
      can :destroy, Post
      can :update, Post
      can :create, Post
      can :read, Post
      can :ban, User  
    elsif user.role == 'user'
      can :read, :all
      can :discover, User
      can [:create, :update, :destroy], Post, user_id: user.id
      can :create, Comment
      can [:update, :destroy], Comment, user_id: user.id
      can :create, Like
      can :destroy, Like, user_id: user.id
      can :update, User, id: user.id
      can [:create, :destroy], Follower, follower_id: user.id
    end
  end
end
