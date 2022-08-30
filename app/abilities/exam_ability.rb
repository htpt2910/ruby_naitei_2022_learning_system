class ExamAbility
  include CanCan::Ability
  def initialize user
    return unless user

    if user.admin?
      can :read, Exam
    else
      can :manage, Exam
    end
  end
end
