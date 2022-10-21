module Admin
  class ArticlesController < AdminController
    before_action :set_authorisation_status

    private
    def set_authorisation_status
      authorize [:admin, :articles]
      @is_admin_panel = true
    end
  end
end
