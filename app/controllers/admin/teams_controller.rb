module Admin
  class TeamsController < BaseCategoriesController
    before_action :resource, :model

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

    def model
      Team
    end
  end
end
