class AddMainArticleAndBreakdownColumnToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :is_part_of_main_articles, :boolean, default: false
    add_column :articles, :is_part_of_breakdown, :boolean, default: false
  end
end
