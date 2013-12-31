class AddOrderToContains < ActiveRecord::Migration
  def change
    add_column :contains, :order, :integer
  end
end
