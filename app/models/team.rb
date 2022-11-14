class Team < ApplicationRecord
  validates :title, presence: true
  belongs_to :subcategory
  has_many :articles, dependent: :destroy
end
