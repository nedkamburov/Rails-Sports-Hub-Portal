class Comment < ApplicationRecord
  validates :content, :user_id, :article_id, presence: true

  belongs_to :user
  belongs_to :article
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :likes, as: :likeable
  has_many :dislikes, as: :dislikeable

  def self.custom_sort_by(criterion)
    case criterion
    when "2"
      order(updated_at: :desc)
    when "3"
      order(created_at: :asc)
    else
      left_joins(:likes)
      .group(:id)
      .order('COUNT(likes.id) DESC')
    end
  end
end
