class CreateSubcategories < ActiveRecord::Migration[7.0]
  def change
    create_table :subcategories do |t|
      t.belongs_to :category, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
