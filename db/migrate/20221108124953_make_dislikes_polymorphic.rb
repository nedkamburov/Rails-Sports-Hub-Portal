class MakeDislikesPolymorphic < ActiveRecord::Migration[7.0]
  def change
    rename_column :dislikes, :comment_id, :dislikeable_id
    add_column :dislikes, :dislikeable_type, :string, index: { name: 'index_dislikes_on_user_dislikeable_id_and_type' }

    add_index :dislikes, [:user_id, :dislikeable_id, :dislikeable_type], unique: true, name: 'index_dislikes_on_user_dislikeable_id_and_type'
    add_index :dislikes, [:dislikeable_id, :dislikeable_type]
  end
end
