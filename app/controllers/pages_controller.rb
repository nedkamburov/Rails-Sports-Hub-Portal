class PagesController < ApplicationController
  rescue_from ::ActionView::MissingTemplate, with: :missing_template
  
  def show
    @category = Category.friendly.find(params[:id])
    @main_articles = Article.where(category: @category)

    @most_commented = Article.where.not(category_id: Category.where(category_type: 'videos')).limit(3).order(created_at: :desc)
    @most_popular = Article.where.not(category_id: Category.where(category_type: 'videos')).limit(3).order(created_at: :asc)
    render corresponding_view
  end

  def home
    @main_articles = Article.where(is_part_of_main_articles: true).order("RANDOM()")
    @breakdown_articles = Article.where(is_part_of_breakdown: true).order("RANDOM()")
    @photo_of_the_day = PhotoOfTheDay.last
    @most_commented = Article.limit(3).order(created_at: :desc)
    @most_popular = Article.limit(3).order(created_at: :asc)
  end

  def create
  end

  def global_search
    search_term = params[:search_term]
    search_results = Article.search_article(search_term)

    render partial: 'pages/search_results', locals: {search_results: search_results}
  end

  protected
  def corresponding_view
      params[:id]
  end

  def missing_template(exception)
    render 'show'
    return
  end
end
