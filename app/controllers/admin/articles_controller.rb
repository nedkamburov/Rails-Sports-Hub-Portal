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

    def toggle_status
      @article = Article.find(params[:id])
      if @article.published? then @article.unpublished!
      elsif @article.unpublished? then @article.published!
      end

      redirect_to admin_articles_path, notice: "Status was updated successfully."
    end

    def sort
      params[:order].each do |item|
        Article.find(item[:id]).update(position: item[:position])
      end

      head :ok # Make sure Rails doesn't look for a view
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
