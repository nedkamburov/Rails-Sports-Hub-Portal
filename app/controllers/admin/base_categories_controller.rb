module Admin
  class BaseCategoriesController < AdminController
    before_action :resource
    before_action :set_model, only: %i[ show edit update destroy ]

    def index
    end

    def show
    end

    def new
      @model = model.new
    end

    def create
      @model = model.new(permitted_params)
      respond_to do |format|
        if @model.save
          format.html { redirect_to admin_categories_path, notice: "Your #{model.model_name.singular} is now created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @model.update(permitted_params)
          format.html { redirect_to admin_categories_path, notice: "Your #{model.model_name.singular} was successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @model.destroy

      redirect_to admin_categories_path, status: :see_other
    end

    def sort
      params[:order].each do |item|
        model.find(item[:id]).update(position: item[:position])
      end

      head :ok # Make sure Rails doesn't look for a view
    end

    private
    def set_model
      @model = model.find(params[:id])
    end
  end
end
