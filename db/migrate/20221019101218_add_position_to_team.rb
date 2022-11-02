class AddPositionToTeam < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :position, :integer, default: 0
  end
end
