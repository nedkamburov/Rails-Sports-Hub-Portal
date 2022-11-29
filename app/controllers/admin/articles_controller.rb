module Admin
  class ArticlesController < AdminController
    before_action :set_parent_categories, only: %i[ new show create edit update]
    before_action :set_article, only: %i[ edit update destroy toggle_status]
    layout "application_dashboard"

    def index
    end

    def show
      @subcategories = Subcategory.where(category_id: @category.id)
      @teams = Team.where(subcategory_id: params[:subcategory_id])
      @articles = Article.by_category(@category.id)
                         .by_subcategory(params[:subcategory_id])
                         .by_team(params[:team_id])
                         .where('headline LIKE :search OR caption LIKE :search', search: "%#{params[:search]}%")
                         .order('position ASC')
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)

      respond_to do |format|
        if @article.save
          format.html { redirect_to admin_article_path(@article.category), notice: "Your article is now created." }
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
          format.html {
            if params['remove_article_from_section'].present?
              redirect_to admin_root_path
            else
              redirect_to admin_article_path(@article.category), notice: "Your article was successfully updated."
            end
          }
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

      redirect_to admin_article_path(@article.category), notice: "Status was updated successfully."
    end

    def update_groupings
      # return if Article.where(is_part_of_main_articles: true).count > 5

      @article = Article.find(params[:article_id])
      grouping_type = params[:grouping_type]
      @article.update(is_part_of_main_articles: true) if (grouping_type== 'grouping_main_articles')
      @article.update(is_part_of_breakdown: true) if (grouping_type == 'grouping_breakdown')

      redirect_to admin_root_path, notice: "Article has been added to the section successfully."
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
                                      :subcategory_id,
                                      :team_id,
                                      :status,
                                      :has_comments,
                                      :is_part_of_main_articles,
                                      :is_part_of_breakdown
      )
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def set_parent_categories
      category_slug = params[:category_slug] || params[:id]
      return if category_slug.blank?
      @category = Category.friendly.find(category_slug)
      @subcategories = @category.subcategories || []
      @teams = @subcategories.flat_map(&:teams) || []
    end
  end
end
