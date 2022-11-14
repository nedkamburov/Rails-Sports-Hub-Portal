class RemoveLikesAndDislikesColumnsFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :likes
    remove_column :comments, :dislikes
  end
end
