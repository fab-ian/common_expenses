class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :create, :read, :update, :destroy, to: :crud

    can :crud, Item, user_id: user.id
    can :read, Item.allow_show(user.id)
  end
end
