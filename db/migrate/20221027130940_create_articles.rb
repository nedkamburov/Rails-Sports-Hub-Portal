class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :headline
      t.string :caption
      t.text :content
      t.string :picture
      t.string :picture_alt
      t.boolean :has_comments
      t.integer :status
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
