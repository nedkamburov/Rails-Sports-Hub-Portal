module Admin
  class SubcategoriesController < AdminController
    before_action :set_authorisation_status
    before_action :set_subcategory, only: %i[ show edit update destroy ]

    def index
    end

    def show
    end

    def new
      @subcategory = Subcategory.new
    end

    def create
      @subcategory = Subcategory.new(subcategory_params)

      respond_to do |format|
        if @subcategory.save
          format.html { redirect_to admin_subcategories_path, notice: "Your subcategory is now created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @subcategory.update(subcategory_params)
          format.html { redirect_to admin_subcategories_path, notice: "Your subcategory was successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    def sort
      params[:order].each do |item|
        Subcategory.find(item[:id]).update(position: item[:position])
      end

      head :ok # Make sure Rails doesn't look for a view
    end

    def destroy
      @subcategory.destroy

      redirect_to admin_subcategories_path, status: :see_other
    end

    private
    def set_authorisation_status
      authorize [:admin, :subcategories]
      @is_admin_panel = true
    end

    def subcategory_params
      params.require(:subcategory).permit(:title,
                                          :position,
                                          :category_id
                                          )
    end

    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
    end
  end
end
