class CreateFooterPages < ActiveRecord::Migration[7.0]
  def change
    create_table :footer_pages do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.integer :page_type, null: false
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end
