class Subcategory < ApplicationRecord
  validates :title, presence: true
  belongs_to :category
  has_many :teams, dependent: :destroy
  has_many :articles, dependent: :destroy
end
