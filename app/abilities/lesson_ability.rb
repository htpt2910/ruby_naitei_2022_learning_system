class LessonAbility
  include CanCan::Ability
  def initialize user
    return if user.blank?

    can :read, Lesson

    return unless user.admin?

    can :manage, Lesson
  end
end
