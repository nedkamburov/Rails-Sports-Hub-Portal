class Comment < ApplicationRecord
  validates :content, :user_id, :article_id, presence: true

  belongs_to :user
  belongs_to :article
end
