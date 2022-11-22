require 'rails_helper'

RSpec.describe Category, type: :model do
   let(:category) { FactoryBot.build(:category) }

   it 'must be valid' do
     expect(category).to be_valid
   end

   describe 'title' do
      it 'must be present' do
        expect(category.title).to_not be_nil
      end
    end

    describe 'position' do
      it 'must be present' do
        expect(category.position).to_not be_nil
      end
    end

   describe 'read_only' do
     it 'must be present' do
       expect(category.read_only).to_not be_nil
     end

     it 'must be "false" by default' do
       expect(category.read_only).to be_falsy
     end
   end

   describe 'category_type' do
     it 'must be present' do
       expect(category.category_type).to_not be_nil
     end

     it 'must be "articles" by default' do
       expect(category.category_type).to eq 'articles'
     end
   end

   describe 'slug' do
     before do
       category.save!
     end

     it 'must be present' do
       expect(category.slug).to_not be_nil
     end

     it 'must be similar to the title' do
       expect(category.slug).to include(*category.title.split.map { |s| s.downcase })
     end
   end

    describe 'subcategories' do
      before(:all) do
        @category = FactoryBot.create(:category)
        @category.subcategories.create(title: 'Subcategory')
        @subcategory = @category.subcategories.first
        @subcategory.teams.create(title: 'Team')
        @team = @subcategory.teams.first
      end

      it 'must be able to access subcategories' do
        expect(@category.subcategories).to_not be_empty
      end

      it 'must be able to access the subcategory properties' do
        expect(@subcategory.title).to eq 'Subcategory'
        expect(@subcategory.teams).to_not be_empty
      end

      it 'must be able to access the teams properties' do
        expect(@team).to be_valid
        expect(@team.title).to_not be_empty
      end
    end

end