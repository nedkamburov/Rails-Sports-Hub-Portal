module Admin
  class PagesController < AdminController
    before_action :set_authorisation_status
    def home
      @users = User.all
    end

    def information_architecture
      @categories = Category.where(category_type: 'articles').order("position ASC")
    end

    private
    def set_authorisation_status
      authorize [:admin, :pages]
      @is_admin_panel = true
    end
  end
end
