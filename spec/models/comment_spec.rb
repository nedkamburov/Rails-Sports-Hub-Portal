require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }

  it 'must be valid' do
    expect(comment).to be_valid
  end

  describe 'author' do
    it 'must be present' do
      expect(comment.user).to_not be_nil
    end
  end

  describe 'article' do
    it 'must be present' do
      expect(comment.article).to_not be_nil
    end
  end

  describe 'likes' do
    it 'must accept likes' do
      expect { FactoryBot.create(:like, likeable: comment) }.to_not raise_error
      expect(comment.likes).to_not be_empty
    end

    it 'must reverse the opinion if a dislike already existed' do
      dislike = FactoryBot.create(:dislike, dislikeable: comment)
      expect { FactoryBot.create(:like, likeable: comment) }.to_not raise_error
      expect(comment.likes).to_not be_empty
      expect { comment.dislikes.find(id: dislike.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'dislikes' do
    it 'must accept dislikes' do
      expect { FactoryBot.create(:dislike, dislikeable: comment) }.to_not raise_error
      expect(comment.dislikes).to_not be_empty
    end

    it 'must reverse the opinion if a like already existed' do
      like = FactoryBot.create(:like, likeable: comment)
      expect { FactoryBot.create(:dislike, dislikeable: comment) }.to_not raise_error
      expect(comment.dislikes).to_not be_empty
      expect { comment.likes.find(id: like.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'subcomments' do
    it 'must be able to accept other subcomments' do
      expect(comment.comments).to be_empty
      expect { FactoryBot.create(:comment, parent_id: comment.id) }.to_not raise_error
    end
  end
end