class Article < ApplicationRecord
  enum status: {unpublished: 0, published: 1}
  validates :headline, :caption, :content, :picture, :picture_alt, presence: true

  belongs_to :team
  has_rich_text :content
end
