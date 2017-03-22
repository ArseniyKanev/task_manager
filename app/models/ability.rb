class Ability

  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: nil)
    if user.admin?
      can :manage, Task
      can :manage, Attachment
    elsif user.user?
      can :manage, Task, user_id: user.id
      can :read, Attachment, task_id: user.task_ids
    end
  end

end
