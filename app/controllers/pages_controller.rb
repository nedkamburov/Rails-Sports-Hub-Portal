class PagesController < ApplicationController
  rescue_from ::ActionView::MissingTemplate, with: :missing_template
  before_action :set_most_articles, only: %i[show home]
  
  def show
    begin
      @category = Category.friendly.find(params[:id])
      @main_articles = Article.where(category: @category).order(:position)
      if @main_articles.empty?
        redirect_to root_path, notice: "No articles in this category yet."
        return
      end
    rescue ActiveRecord::RecordNotFound => e
    end

    render corresponding_view
  end

  def home
    @main_articles = Article.where(is_part_of_main_articles: true).order("RANDOM()")
    @breakdown_articles = Article.where(is_part_of_breakdown: true).order("RANDOM()")
    @photo_of_the_day = PhotoOfTheDay.last
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

  def set_most_articles
    articles = Article.includes(comments: :likes).group(['articles.id', 'comments.id', 'likes.id'])
    @most_popular = articles.order("likes.count desc").first(3)
    @most_commented = articles.order("comments.count desc").first(3)
  end
end
