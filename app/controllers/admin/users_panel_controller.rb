module Admin
  class UsersPanelController < AdminController
    before_action :set_footer_page, only: %i[ show edit update destroy toggle_status ]
    layout "application_dashboard"

    def index
      @users = User.all
      @admins = @users.where(role: :admin)

      @user_roles = User.roles.dup
      @user_roles[:admin] = @admins.count
      @user_roles[:user] = @users.count - @admins.count
    end

    def new
      @footer_page = FooterPage.new
    end

    def create
      @footer_page = FooterPage.new(footer_page_params)

      respond_to do |format|
        if @footer_page.save
          format.html { redirect_to admin_footer_pages_path, notice: "Footer page was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @footer_page.destroy

      respond_to do |format|
        format.html { redirect_to admin_footer_pages_path, notice: "Footer page was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    def filter_by_page_type
      users = User.where(role: params[:user_role])

      render partial: 'admin/users_panel/users_list', locals: {users: users}
    end

    def toggle_status
      if @footer_page.shown? then @footer_page.hidden!
      elsif @footer_page.hidden? then @footer_page.shown!
      end

      head :ok # Make sure Rails doesn't look for a view
    end

    def resource
      :users_panel
    end

    private
      def set_footer_page
        @footer_page = FooterPage.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def footer_page_params
        params.require(:footer_page).permit(:title, :url, :page_type, :status)
      end
  end
end