class AddOrderToContains < ActiveRecord::Migration
  def change
    add_column :contains, :order, :integer, default 0
  end
end
