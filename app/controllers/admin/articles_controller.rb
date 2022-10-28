module Admin
  class ArticlesController < AdminController
    before_action :set_authorisation_status
    before_action :set_article, only: %i[ show edit update destroy ]

    def index
    end

    def show
      @category = Category.friendly.find(params[:id])
      @articles = []
      @category.subcategories.map {|subcat| subcat.teams.map {|team| @articles.push *team.articles}}
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy

      redirect_to admin_articles_path, status: :see_other
    end

    private
    def set_authorisation_status
      authorize [:admin, :articles]
      @is_admin_panel = true
    end

    def set_article
      # @article = Article.find(params[:id])
    end
  end
end
