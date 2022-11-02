class Team < ApplicationRecord
  validates :title, presence: true
  belongs_to :subcategory
end
