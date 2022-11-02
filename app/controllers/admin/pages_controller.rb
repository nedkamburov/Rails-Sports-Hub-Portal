module Admin
  class PagesController < AdminController
    before_action :resource

    def home
      @users = User.all
    end

    def information_architecture
      @categories = Category.where(category_type: 'articles').order("position ASC")
    end

    def resource
      :pages
    end
  end
end
