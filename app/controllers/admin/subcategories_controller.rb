module Admin
  class SubcategoriesController < BaseCategoriesController

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

    def record
      Subcategory
    end
  end
end
