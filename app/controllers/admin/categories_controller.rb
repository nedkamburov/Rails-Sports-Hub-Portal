module Admin
  class CategoriesController < BaseCategoriesController
    before_action :resource, :model

    private
    def permitted_params
      params.require(:category).permit(:title,
                                       :position,
                                       :read_only,
                                       :category_type
      )
    end

    def resource
      :categories
    end

    def model
      Category
    end
  end
end
