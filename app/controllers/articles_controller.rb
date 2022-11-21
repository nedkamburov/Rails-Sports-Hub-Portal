class ArticlesController < ApplicationController
  before_action :set_article,:published?, :set_comment_sort_criterion, only: %i[ show ]
  @@comments_sort_criterion = nil

  def index
  end

  def show
    @category = Category.find(@article.category_id)
    @team = Team.find(@article.team_id)
    @pagy, @comments = pagy(@article.comments.where(parent_id: nil)
                                             .includes(:user)
                                             .custom_sort_by(@@comments_sort_criterion),
                                             items: 4 )
    @load_more = params[:page]
    @more_articles = @category.articles.where(status: 'published').limit(6).order("RANDOM()")
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def published?
    if @article.status != 'published'
      flash[:notice] = 'You cannot access this article'
      redirect_back(fallback_location: articles_url)
    end
  end

  def set_comment_sort_criterion
    @@comments_sort_criterion = params[:sort_by] if params[:sort_by]
  end

end

