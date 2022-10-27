class Article < ApplicationRecord
  enum status: {draft: 0, published: 1}
  belongs_to :team

  validates :headline, :caption, :content, :picture, :picture_alt, presence: true
end
