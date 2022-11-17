RSpec.describe ArticlesController do
  describe "GET show" do
    it "assigns @category" do
      category = Category.create
      get :show
      expect(assigns(:category)).to eq([category])
    end

    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end
  end
end