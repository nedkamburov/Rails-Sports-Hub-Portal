class AddReadOnlyAndTypeToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :read_only, :boolean, default: false, null: false
    add_column :categories, :category_type, :string, default: 'articles', null: false
  end
end
