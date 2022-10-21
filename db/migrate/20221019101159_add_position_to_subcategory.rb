class AddPositionToSubcategory < ActiveRecord::Migration[7.0]
  def change
    add_column :subcategories, :position, :integer, default: 0
  end
end
