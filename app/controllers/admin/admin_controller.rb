class Admin::AdminController < ApplicationController

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action. Try to log in as admin."
    redirect_back(fallback_location: new_user_session_path)
  end
end
