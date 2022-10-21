module Admin
  class CategoriesController < AdminController
    before_action :set_authorisation_status

    def index

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

    def sort
      params[:order].each do |item|
        Category.find(item[:id]).update(position: item[:position])
      end

      head :ok # Make sure Rails doesn't look for a view
    end

    private
    def set_authorisation_status
      authorize [:admin, :categories]
      @is_admin_panel = true
    end

    def category_params
      params.require(:category).permit(:title,
                                       :position,
                                       :read_only,
                                       :category_type
                                      )
    end
  end
end