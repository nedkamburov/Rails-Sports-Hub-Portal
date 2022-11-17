require 'rails_helper'

RSpec.describe Category, type: :model do
   let(:category) { FactoryBot.build(:category) }

   describe 'title' do
      it 'must be present' do
        expect(category).to be_valid
        expect(category.title).to_not be_empty
      end
    end

    describe 'position' do
      it 'must be present' do
        expect(category).to be_valid
        expect(category.position).to_not be nil
      end
    end

   describe 'read_only' do
     it 'must be present' do
       expect(category).to be_valid
       expect(category.read_only).to_not be nil
     end

     it 'must be "false" by default' do
       expect(category).to be_valid
       expect(category.read_only).to be false
     end
   end

   describe 'category_type' do
     it 'must be present' do
       expect(category).to be_valid
       expect(category.category_type).to_not be nil
     end

     it 'must be "articles" by default' do
       expect(category).to be_valid
       expect(category.category_type).to eq 'articles'
     end
   end

   describe 'slug' do
     it 'must be present' do
       expect(category).to be_valid
       expect(category.slug).to_not be nil
     end

     it 'must be similar to the title' do
       expect(category).to be_valid
       expect(category.slug).to include(*category.title.split.map { |s| s.downcase })
     end
   end

    describe 'subcategories' do
      category = FactoryBot.create(:category)
      category.subcategories.create(title: 'Subcategory')

      it 'must accept subcategories' do
        expect(category.subcategories).to_not be_empty
      end

      subcategory = category.subcategories.first
      subcategory.teams.create(title: 'Team')
      it 'must be able to access the subcategory properties' do
        expect(subcategory.title).to eq 'Subcategory'
        expect(subcategory.teams).to_not be_empty
      end

      it 'must be able to access the teams properties' do
        team = subcategory.teams.first
        expect(team).to be_valid
        expect(team.title).to_not be_empty
      end
    end

end