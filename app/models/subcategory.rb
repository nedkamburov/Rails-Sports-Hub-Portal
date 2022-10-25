class Subcategory < ApplicationRecord
  validates :title, presence: true
  belongs_to :category
  has_many :teams, dependent: :delete_all
end
