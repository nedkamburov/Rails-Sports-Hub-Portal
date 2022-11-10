class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show ]
  before_action :published?, only: %i[ show ]
  def index
  end

  def show
    @category = Category.find(@article.category_id)
    @team = Team.find(@article.team_id)

    @pagy, @comments = pagy_countless(@article.comments.where(parent_id: nil).includes(:user).order(created_at: :desc),
                                      items: 4 )
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

end

