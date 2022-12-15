module Admin
  class UsersPanelController < AdminController
    before_action :set_user, only: %i[ edit update destroy get_general_info change_admin_status change_lock_status ]
    layout "application_dashboard"

    def index
      @all_users = User.all.order(:name)
      @admins = @all_users.where(role: :admin)
      @users = @all_users.where(role: :user)

      @user_roles = User.roles.dup
      @user_roles[:admin] = @admins.count
      @user_roles[:user] = @users.count
      @subscribed_user = Newsletter.find_by(email: @users.first.email)
    end

    def destroy
      @user.destroy

      respond_to do |format|
        format.html { redirect_to admin_users_panel_index_path, notice: "User #{@user.name} (ID: #{@user.id}) was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    def filter_by_user_role
      users = User.where(role: params[:user_role]).order(:name)

      render partial: 'admin/users_panel/users_list', locals: {users: users}
    end

    def get_general_info
      @subscribed_user = Newsletter.find_by(email: @user.email)
      render partial: 'admin/users_panel/general_info', locals: {user: @user, subscribed: @subscribed_user}
    end

    def change_admin_status
      if @user.user? then @user.admin!
      elsif @user.admin? then @user.user!
      end

      redirect_to admin_users_panel_index_path, notice: "The admin status of user #{@user.name} (ID: #{@user.id}) was successfully changed."
    end

    def change_lock_status
      if @user.access_locked? then @user.unlock_access!
      else @user.lock_access!
      end

      redirect_to admin_users_panel_index_path, notice: "The status of user #{@user.name} (ID: #{@user.id}) was successfully changed."
    end

    def resource
      :users_panel
    end

    private
      def set_user
        @user = User.find(params[:id])
      end
  end
end