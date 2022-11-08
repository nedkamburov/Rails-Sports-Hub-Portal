class Category < ApplicationRecord
  validates :title, presence: true
  has_many :subcategories, dependent: :destroy
  has_many :articles, dependent: :destroy
  
  extend FriendlyId
  friendly_id :title, use: :slugged
end