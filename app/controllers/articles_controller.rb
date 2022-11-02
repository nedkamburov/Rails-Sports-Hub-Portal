class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show ]
  def index
  end

  def show
    @category = Category.find(@article.category_id)
    @team = Team.find(@article.team_id)
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end
end

