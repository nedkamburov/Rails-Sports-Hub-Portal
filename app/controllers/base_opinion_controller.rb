class BaseOpinionController < ApplicationController
  before_action :check_for_opinion_collision, only: :create

  def create
    @opinion = current_user.send(opinion_type).new(permitted_params)

    if !@opinion.save
      flash[:notice] = @opinion.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: articles_url)
  end

  def destroy
    @opinion = current_user.send(opinion_type).find(params[:id])
    @opinion.destroy
    redirect_back(fallback_location: articles_url)
  end

  private
  def check_for_opinion_collision
    if opinion_type == :dislikes
      @opposite_opinion = Comment.find(permitted_params[:dislikeable_id]).likes.find_by(user: current_user)
    else
      @opposite_opinion = Comment.find(permitted_params[:likeable_id]).dislikes.find_by(user: current_user)
    end

    if !@opposite_opinion.nil?
      flash[:notice] = 'The opposite opinion is already true. Unmark it to proceed.'
      redirect_back(fallback_location: articles_url)
    end
  end
end
