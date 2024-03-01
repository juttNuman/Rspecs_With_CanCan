# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.customer?
      can :read, Product
    elsif user.manager?
      can :manage, :all
    end
  end
end
