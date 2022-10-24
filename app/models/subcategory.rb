class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :teams, dependent: :delete_all
end
