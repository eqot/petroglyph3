class AddPositionToContains < ActiveRecord::Migration
  def change
    add_column :contains, :position, :integer
  end
end
