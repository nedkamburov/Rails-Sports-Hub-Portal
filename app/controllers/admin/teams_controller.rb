module Admin
  class TeamsController < AdminController
    before_action :set_authorisation_status

    def index
    end
    def new
      @team = Team.new
    end

    def create
      @team = Team.new(team_params)

      respond_to do |format|
        if @team.save
          format.html { redirect_to admin_teams_path, notice: "Your team is now created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @team.update(team_params)
          format.html { redirect_to admin_teams_path, notice: "Your team was successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    def sort
      params[:order].each do |item|
        Team.find(item[:id]).update(position: item[:position])
      end

      head :ok # Make sure Rails doesn't look for a view
    end

    private
    def set_authorisation_status
      authorize [:admin, :teams]
      @is_admin_panel = true
    end

    def team_params
      params.require(:team).permit(:title,
                                   :position,
                                   :subcategory_id
                                   )
    end
  end
end
