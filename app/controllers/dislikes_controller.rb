class DislikesController < BaseOpinionController

  private
  def permitted_params
    params.require(:dislike).permit(:dislikeable_id, :dislikeable_type)
  end

  def opinion_type
    :dislikes
  end
end
