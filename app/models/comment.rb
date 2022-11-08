class Comment < ApplicationRecord
  validates :content, :user_id, :article_id, presence: true

  belongs_to :user
  belongs_to :article
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id
  has_many :likes, as: :likeable
  has_many :dislikes, as: :dislikeable
end
