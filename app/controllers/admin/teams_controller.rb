module Admin
  class TeamsController < BaseCategoriesController

    private
    def permitted_params
      params.require(:team).permit(:title,
                                   :position,
                                   :subcategory_id
                                   )
    end

    def resource
      :teams
    end

    def record
      Team
    end
  end
end
