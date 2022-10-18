class Category < ApplicationRecord
  has_many :nested_categories, class_name: "Category", foreign_key: "parent_category_id", :dependent => :destroy
  belongs_to :parent_category, class_name: "Category", optional: true

  has_many :subcategories, :dependent => :destroy
end
