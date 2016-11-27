class AddStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipped, :boolean, default: false
  end
end
