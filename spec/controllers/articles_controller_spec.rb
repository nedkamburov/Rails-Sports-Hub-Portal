require "rails_helper"

RSpec.describe ArticlesController, type: :controller do
  let (:article) { FactoryBot.create(:article) }
  let (:category) { article.category }
  let (:team) { article.team }

  describe "GET show" do
    it "has a 200 status code" do
      get :show, params: {id: article.id}
      expect(response.status).to eq(200)
    end

    it "assigns @category" do
      get :show, params: {id: article.id}
      expect(assigns(:category)).to eq(category)
    end

    it "assigns @team" do
      get :show, params: {id: article.id}
      expect(assigns(:team)).to eq(team)
    end

    it "assigns @comments" do
      comment = FactoryBot.create(:comment)
      article.comments.push(comment)

      get :show, params: {id: article.id}
      expect(assigns(:comments)).to eq(article.comments)
    end

    it "assigns @more_articles" do
      article2 = FactoryBot.create(:article)
      category.articles.push(article2)

      get :show, params: {id: article.id}
      expect(assigns(:more_articles).count).to be >= 2
    end

    it "returns random @more_articles" do
      article2 = FactoryBot.create(:article, headline: 'Article 2')
      article3 = FactoryBot.create(:article, headline: 'Article 3')
      category.articles.push(article2, article3)
      random_articles = false

      5.times do
        get :show, params: {id: article.id}
        returned_articles = assigns(:more_articles)
        if category.articles != returned_articles
          random_articles = true
          break
        end
      end

      expect(random_articles).to be_truthy
    end
  end
end