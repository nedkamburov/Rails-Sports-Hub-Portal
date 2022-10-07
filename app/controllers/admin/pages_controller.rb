module Admin
  class PagesController < AdminController
    def home
      authorize [:admin, :pages]
      @users = User.all
    end
  end
end
