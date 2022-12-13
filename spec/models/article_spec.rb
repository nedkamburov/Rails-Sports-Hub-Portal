require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { FactoryBot.build(:article) }

  it 'must be valid' do
    expect(article).to be_valid
  end

  describe 'headline' do
    it 'must be present' do
      expect(article.headline).to_not be_nil
    end
  end

  describe 'caption' do
    it 'must be present' do
      expect(article.caption).to_not be_nil
    end
  end

  describe 'picture_alt' do
    it 'must be present' do
      expect(article.picture_alt).to_not be_nil
    end
  end

  describe 'has_comments' do
    it 'must be present' do
      expect(article.has_comments).to_not be_nil
    end

    it 'must be "true" by default' do
      expect(article.has_comments).to be_truthy
    end
  end

  describe 'status' do
    it 'must be present' do
      expect(article.status).to_not be_nil
    end

    it 'must be string (using enum)' do
      expect(article.status).to be_a(String)
    end

    it 'must be "published" by default' do
      expect(article.status).to eq 'published'
    end
  end

  describe 'position' do
    it 'must be present' do
      expect(article.position).to_not be_nil
    end
  end

  describe 'associations' do
    before(:each) do
      @article = FactoryBot.create(:article)
      @parent_category = @article.category
      @parent_subcategory = @article.subcategory
      @parent_team = @article.team
    end

    describe 'parent category' do
      it 'must be associated with a category' do
        expect(@article.category).to be == @parent_category
      end

      it 'must be able to access parent category properties' do
        expect(@parent_category.title).to eq 'NFL'
        expect(@parent_category.subcategories).to_not be_nil
        expect(@parent_category.articles).to_not be_empty
      end
    end

    describe 'parent subcategory' do
      it 'must be associated with a subcategory' do
        expect(@article.subcategory).to be == @parent_subcategory
      end

      it 'must be able to access parent subcategory properties' do
        expect(@parent_subcategory.title).to eq 'AFC West'
        expect(@parent_subcategory.teams).to_not be_nil
        expect(@parent_subcategory.articles).to_not be_empty
      end
    end

    describe 'parent team' do
      it 'must be associated with a team' do
        expect(@article.team).to be == @parent_team
      end

      it 'must be able to access parent teams properties' do
        expect(@parent_team.title).to eq 'Memphis'
        expect(@parent_team.articles).to_not be_empty
      end
    end
  end
end