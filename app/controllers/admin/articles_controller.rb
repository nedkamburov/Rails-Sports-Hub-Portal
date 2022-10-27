module Admin
  class ArticlesController < AdminController
    # before_action :set_authorisation_status
    def index
    end

    def show
      @category = Category.friendly.find(params[:id])
      @articles = []
      @category.subcategories.map {|subcat| subcat.teams.map {|team| @articles.push *team.articles}}
    end

    private
    def set_authorisation_status
      authorize [:admin, :articles]
      @is_admin_panel = true
    end
  end
end
