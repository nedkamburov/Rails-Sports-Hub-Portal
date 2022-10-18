module Admin
  class PagesController < AdminController
    before_action :set_authorisation_status, only: %i[ show edit update destroy ]
    def home
      @users = User.all
    end

    def information_architecture
      @static_pages = Category.all.reject { |page| page.title == 'Home' || page.title == 'News' || !page.parent_category_id.nil? }
      @sport_categories = Category.find_by(title: 'News').nested_categories
    end

    def set_authorisation_status
      authorize [:admin, :pages]
      @is_admin_panel = true
    end
  end
end
