class MigrateArticleContentToActionText < ActiveRecord::Migration[7.0]
  include ActionView::Helpers::TextHelper
  def change
    rename_column :articles, :content, :content_old
    Article.all.each do |article|
      article.update_attribute(:content, simple_format(article.content_old))
    end
    remove_column :articles, :content_old
  end
end
