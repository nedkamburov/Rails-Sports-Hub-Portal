class RemoveFkFromLikesToComments < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :likes, :comments
  end
end
