class CourseAbility
  include CanCan::Ability
  def initialize user
    return if user.blank?

    can :read, Course

    return unless user.admin?

    can :manage, Course
  end
end
