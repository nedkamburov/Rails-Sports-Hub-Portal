class RemoveArticlePictureColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :picture
  end
end
