class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.references :subcategory, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
