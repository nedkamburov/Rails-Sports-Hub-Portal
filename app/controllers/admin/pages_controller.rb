module Admin
  class PagesController < AdminController

    def home
      @users = User.all
      @categories = Category.all.where(category_type: 'articles')
      @subcategories = Subcategory.where(category_id: params[:category_id])
      @teams = Team.where(subcategory_id: params[:subcategory_id])
      @articles = Article.where(category_id: params[:category_id])
                         .by_subcategory(params[:subcategory_id])
                         .by_team(params[:team_id])

      @main_articles_left = @articles.where(is_part_of_main_articles: false)
      @breakdown_articles_left = @articles.where(is_part_of_breakdown: false)

      @main_articles = Article.where(is_part_of_main_articles: true)
      @breakdown_articles = Article.where(is_part_of_breakdown: true)

      if params[:add_article_to_section].present?
        redirect_to update_groupings_admin_articles_path(article_id: params[:article_id],
                                                       grouping_type: params[:grouping_type])
      end

      @photo_of_the_day = PhotoOfTheDay.first
    end

    def information_architecture
      @categories = Category.where(category_type: 'articles').order("position ASC")
    end

    def resource
      :pages
    end
  end
end
