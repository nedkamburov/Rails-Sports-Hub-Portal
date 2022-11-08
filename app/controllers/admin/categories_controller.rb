module Admin
  class CategoriesController < BaseCategoriesController
    before_action :set_record, only: %i[ show edit update destroy ]

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

    def record
      Category
    end

    def set_record # TODO: Set the record here as only Category uses friendly Id for now
      @record = Category.friendly.find(params[:id])
    end
  end
end
