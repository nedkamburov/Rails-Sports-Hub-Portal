class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :headline, null: false
      t.string :caption, null: false
      t.text :content, null: false
      t.string :picture, null: false
      t.string :picture_alt, null: false
      t.boolean :has_comments, null: false, default: true
      t.integer :status, null: false, default: 0
      t.belongs_to :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
