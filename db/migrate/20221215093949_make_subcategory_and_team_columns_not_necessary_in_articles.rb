class MakeSubcategoryAndTeamColumnsNotNecessaryInArticles < ActiveRecord::Migration[7.0]
  def change
    change_column_null :articles, :subcategory_id, true, 0
    change_column_null :articles, :team_id, true, 0
  end
end
