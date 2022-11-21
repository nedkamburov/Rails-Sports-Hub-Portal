class PhotoOfTheDay < ApplicationRecord
  validates :title, :description, :picture_alt, :author, presence: true

  has_one_attached :picture

  def self.instance
    first_or_create!(singleton_guard: 0)
  end
end
