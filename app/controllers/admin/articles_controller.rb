module Admin
  class ArticlesController < AdminController
    before_action :resource
    before_action :set_article, only: %i[ edit update destroy toggle_status]

    def index
    end

    def show
      @category = Category.friendly.find(params[:id])
      @articles = Article.where(category_id: @category.id)
                         .where('headline LIKE :search OR caption LIKE :search', search: "%#{params[:search]}%")
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)

      respond_to do |format|
        if @article.save
          format.html { redirect_to admin_root_path, notice: "Your article is now created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to admin_root_path, notice: "Your article was successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @article.destroy

      redirect_to admin_articles_path, status: :see_other
    end

    def toggle_status
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
    def resource
      :articles
    end

    def article_params
      params.require(:article).permit(:headline,
                                      :caption,
                                      :content,
                                      :picture,
                                      :picture_alt,
                                      :category_id,
                                      :team_id,
                                      :status,
                                      :has_comments
      )
    end

    def set_article
      @article = Article.find(params[:id])
    end
  end
end
