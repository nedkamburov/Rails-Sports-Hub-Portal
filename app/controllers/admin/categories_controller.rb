module Admin
  class CategoriesController < AdminController
    before_action :resource
    before_action :set_category, only: %i[ show edit update destroy ]

    def index
    end

    def show
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html { redirect_to admin_categories_path, notice: "Your category is now created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to admin_categories_path, notice: "Your category was successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @category.destroy

      redirect_to admin_categories_path, status: :see_other
    end

    def sort
      params[:order].each do |item|
        Category.find(item[:id]).update(position: item[:position])
      end

      head :ok # Make sure Rails doesn't look for a view
    end

    private
    def category_params
      params.require(:category).permit(:title,
                                       :position,
                                       :read_only,
                                       :category_type
                                      )
    end
    def set_category
      @category = Category.find(params[:id])
    end

    def resource
      :categories
    end
  end
end
