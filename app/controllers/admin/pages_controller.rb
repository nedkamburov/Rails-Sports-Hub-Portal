module Admin
  class PagesController < AdminController
    before_action :set_authorisation_status, only: %i[ show edit update destroy ]
    def home
      @users = User.all
    end

    def information_architecture
      @static_pages = Category.all.reject { |page| page.title == 'News' || page.title == 'Home'  }
      @sports = Category.find_by(title: 'News')
    end

    def set_authorisation_status
      authorize [:admin, :pages]
      @is_admin_panel = true
    end
  end
end
