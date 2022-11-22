class PhotoOfTheDay < ApplicationRecord
  validates :title, :description, :picture_alt, :author, presence: true

  has_one_attached :picture
end
