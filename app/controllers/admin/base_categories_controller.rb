module Admin
  class BaseCategoriesController < AdminController
    before_action :set_record, only: %i[ show edit update destroy ]

    def index
    end

    def show
    end

    def new
      @record = record.new
    end

    def create
      @record = record.new(permitted_params)
      respond_to do |format|
        if @record.save
          format.html { redirect_to admin_categories_path, notice: "Your #{record.model_name.singular} is now created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @record.update(permitted_params)
          format.html { redirect_to admin_categories_path, notice: "Your #{record.model_name.singular} was successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @record.destroy

      redirect_to admin_categories_path, status: :see_other
    end

    def sort
      params[:order].each do |item|
        record.find(item[:id]).update(position: item[:position])
      end

      head :ok # Make sure Rails doesn't look for a view
    end

    private
    def set_record
      @record = record.find(params[:id])
    end
  end
end
