require "rails_helper"

RSpec.describe Admin::ArticlesController, type: :controller do
  let (:article) { FactoryBot.create(:article) }
  let (:category) { article.category }
  let (:team) { article.team }

  login_admin

  describe "GET show" do
    it "has a 200 status code" do
      get :show, params: {id: category.id}
      expect(response.status).to eq(200)
    end

    it "should be denied access when user is not authorised and redirects" do
      sign_out @admin_user

      get :show, params: {id: category.id}
      expect(response.status).to eq(302)
    end

    it "assigns @articles" do
      get :show, params: {id: category.id}
      expect(assigns(:articles)).to eq(category.articles)
    end
  end

  describe "POST create" do
    let (:test_category) { FactoryBot.create(:category) }
    let (:create_article) {
      new_article = FactoryBot.attributes_for(:article, category_id: test_category.id)
      post :create, params: {id: category.id, article: new_article}
    }

    it "is persisted in the database" do
      new_article = FactoryBot.attributes_for(:article)
      existing_articles = Article.all.count
      post :create, params: {id: category.id, article: new_article}
      expect(Article.all.count).to be > existing_articles
    end

    it "should fail if no article params are provided" do
      expect { post :create, params: {id: category.id} }.to raise_error(ActionController::ParameterMissing)
    end

    it "returns @article after creation" do
      new_article = FactoryBot.attributes_for(:article)
      post :create, params: {id: category.id, article: new_article}
      expect(assigns(:article)).to be_an_instance_of(Article)
    end

    it "redirects to the new article's category" do
      expect(create_article).to redirect_to(admin_article_path(test_category))
    end
  end

  describe "PUT update" do
    it "updates an article" do
      new_article = FactoryBot.create(:article)
      altered_article = FactoryBot.attributes_for(:article, id: new_article.id, headline: 'Altered!')
      put :update, params: {category_slug: new_article.category.slug, id: new_article.id, article: altered_article}
      expect(altered_article).to_not be == new_article
      expect(Article.find(new_article.id).headline).to eq 'Altered!'
    end
  end

  describe "DELETE destroy" do
    it "deletes an article from the database" do
      new_article = FactoryBot.create(:article)
      existing_articles = Article.all.count
      delete :destroy, params: {id: new_article.id}
      expect(Article.all.count).to be < existing_articles
    end
  end
end