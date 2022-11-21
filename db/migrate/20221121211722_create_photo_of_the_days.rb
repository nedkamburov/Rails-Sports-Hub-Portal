class CreatePhotoOfTheDays < ActiveRecord::Migration[7.0]
  def change
    create_table :photo_of_the_days do |t|
      t.integer  :singleton_guard
      t.string :picture_alt
      t.string :title
      t.text :description
      t.string :author

      t.timestamps
    end
    add_index(:photo_of_the_days, :singleton_guard, :unique => true)
  end
end
