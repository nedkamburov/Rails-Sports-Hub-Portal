module Admin
  class ArticlesController < AdminController
    before_action :resource

    private
    def resource
      :articles
    end
  end
end
