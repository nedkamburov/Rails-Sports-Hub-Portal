module Admin
  class CategoriesController < BaseCategoriesController
    before_action :resource, :model, :set_model

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

    def set_model # TODO: Set the model here as only Category uses friendly Id for now 
      @model = Category.friendly.find(params[:id])
    end
  end
end
