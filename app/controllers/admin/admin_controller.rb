class Admin::AdminController < ApplicationController
  before_action :set_authorisation_status
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action. Try to log in as admin."
    redirect_back(fallback_location: new_user_session_path)
  end

  def set_authorisation_status
    authorize [:admin, resource]
    @is_admin_panel = true
  end
end
