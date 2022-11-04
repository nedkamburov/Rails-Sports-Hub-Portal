class AddSubcategoryReferenceToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :subcategory, null: false, foreign_key: true
  end
end
