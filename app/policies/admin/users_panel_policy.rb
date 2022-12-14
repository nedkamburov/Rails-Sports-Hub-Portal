class Admin::UsersPanelPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    user.present?
  end

  def edit?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present?
  end

  def filter_by_page_type?
    user.present?
  end

  def change_admin_status?
    user.present?
    end

  def change_lock_status?
    user.present?
  end
end
