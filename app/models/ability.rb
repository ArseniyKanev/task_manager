class Ability

  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: nil)
    if user.admin?
      can :manage, Task
    elsif user.user?
      can :manage, Task, user_id: user.id
    end
  end

end
