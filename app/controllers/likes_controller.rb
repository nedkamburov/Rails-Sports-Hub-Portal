class LikesController < BaseOpinionController

  private
  def permitted_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end

  def opinion_type
    :likes
  end
end
