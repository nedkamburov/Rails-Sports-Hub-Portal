class ArticlesController < ApplicationController
  def index
  end

  def show
    @category = Category.friendly.find(params[:id])
  end
end

