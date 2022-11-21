module Admin
  class PhotoOfTheDayController < AdminController
    before_action :set_photo_of_the_day, only: %i[ edit update destroy ]

    def new
      @photo = PhotoOfTheDay.new
    end

    def create
      @photo = PhotoOfTheDay.new(photo_params)
      binding.pry

      respond_to do |format|
        if @photo.save
          format.html { redirect_to admin_root_path, notice: "Your photo is now created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @photo.update(article_params)
          format.html { redirect_to admin_root_path, notice: "Your photo was successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @photo.destroy

      redirect_to admin_root_path, status: :see_other
    end

    private
    def resource
      :photo_of_the_days
    end

    def photo_params
      params.require(:photo_of_the_day).permit(:title,
                                               :description,
                                               :picture,
                                               :picture_alt,
                                               :author
      )
    end

    def set_photo_of_the_day
      @photo = PhotoOfTheDay.find(params[:id])
    end
  end
end
