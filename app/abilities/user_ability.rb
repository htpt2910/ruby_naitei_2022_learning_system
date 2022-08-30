class UserAbility
  include CanCan::Ability
  def initialize user
    can :read, User, id: user.id
  end
end
