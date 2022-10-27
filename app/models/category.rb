class Category < ApplicationRecord
  validates :title, presence: true
  has_many :subcategories, dependent: :delete_all

  extend FriendlyId
  friendly_id :title, use: :slugged
end