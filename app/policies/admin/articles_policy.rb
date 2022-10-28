class Admin::ArticlesPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    user.present?
  end

  def destroy?
    user.present?
  end

  def toggle_status?
    user.present?
  end

  def sort?
    user.present?
  end
end
