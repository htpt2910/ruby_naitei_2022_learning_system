class WordAbility
  include CanCan::Ability
  def initialize user
    return if user.blank?

    can :read, Word

    return unless user.admin?

    can :manage, Word
  end
end
