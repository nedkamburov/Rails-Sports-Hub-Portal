class Category < ApplicationRecord
  has_many :subcategories, dependent: :delete_all
end