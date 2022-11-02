module Admin
  class SubcategoriesController < BaseCategoriesController
    before_action :resource, :model

    private
    def permitted_params
      params.require(:subcategory).permit(:title,
                                          :position,
                                          :category_id
                                          )
    end

    def resource
      :subcategories
    end

    def model
      Subcategory
    end
  end
end
