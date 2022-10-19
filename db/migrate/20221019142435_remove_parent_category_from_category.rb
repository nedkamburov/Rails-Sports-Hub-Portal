class RemoveParentCategoryFromCategory < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :parent_category_id, :bigint
  end
end