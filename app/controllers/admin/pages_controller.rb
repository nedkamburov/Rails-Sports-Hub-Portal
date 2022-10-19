module Admin
  class PagesController < AdminController
    before_action :set_authorisation_status
    def home
      @users = User.all
    end

    def information_architecture
      @categories = Category.all
                            .reject { |page| page.title == 'Home' || page.title == 'News' }
                            .sort_by{ |page| page.position}
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new()

      respond_to do |format|
        if @category.save
          format.html { redirect_to pages_path, notice: "Your category is now created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
    def update
      respond_to do |format|
        if @page.update(category_params)
          format.html { redirect_to pages_path, notice: "Your pages were successfully updated." }
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
      authorize [:admin, :pages]
      @is_admin_panel = true
    end

    def category_params
      params.require(:pages).permit(:title,
                                    :position
                                    )
    end

    def set_page
      @page = Category.find(params[:id])
    end
  end
end
