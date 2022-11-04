class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update ]

  def index
  end

  def new
    Comment.new
  end

  def show
  end

  def create
    @comment = current_user.comments.new(permitted_params)

      if @comment.save
        redirect_to article_path(params[:article_id]), notice: "Your comment is now created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  private
  def permitted_params
    params.require(:comment)
          .permit(:content,
                  :user_id,
                  :article_id,
                  :likes,
                  :dislikes)
          .merge(article_id: params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
