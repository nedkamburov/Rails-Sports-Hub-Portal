module Admin
  class PagesController < AdminController
    def home
      authorize [:admin, :pages]
      @users = User.all
      @is_admin_panel = true
    end

    def footer
      authorize [:admin, :pages]
      @is_admin_panel = true
    end

    def information_architecture
      authorize [:admin, :pages]
      @is_admin_panel = true
    end
  end
end
