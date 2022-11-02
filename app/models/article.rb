class Article < ApplicationRecord
  enum status: {unpublished: 0, published: 1}
  validates :headline, :caption, :content, :picture_alt, presence: true

  belongs_to :category
  belongs_to :team
  has_one_attached :picture
  has_rich_text :content
end
