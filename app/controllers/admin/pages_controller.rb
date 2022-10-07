module Admin
  class PagesController < AdminController
    def home
      authorize [:admin, :pages]
      @users = User.all
      @is_admin_panel = true
    end
  end
end
