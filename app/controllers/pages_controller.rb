class PagesController < ApplicationController
  rescue_from ::ActionView::MissingTemplate, with: :missing_template
  
  def show
    @page = params[:id]

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

  protected

  def corresponding_view
      params[:id]
  end

  def missing_template(exception)
    render 'show'
    return
  end
end
