class Admin::PagesPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def home?
    user.present?
  end
  def footer?
    user.present?
  end
  def information_architecture?
    user.present?
  end
  def show?
    user.present?
  end

end
