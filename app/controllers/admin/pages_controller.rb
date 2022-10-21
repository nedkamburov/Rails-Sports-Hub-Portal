module Admin
  class PagesController < AdminController
    before_action :set_authorisation_status
    def home
      @users = User.all
    end

    def information_architecture
      @categories = Category.all.sort_by{ |page| page.position}
    end

    private
    def set_authorisation_status
      authorize [:admin, :pages]
      @is_admin_panel = true
    end
  end
end
