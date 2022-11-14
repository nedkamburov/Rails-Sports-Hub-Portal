class ChangeDefaultValueForArticleStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default :articles, :status, 1
  end
end
