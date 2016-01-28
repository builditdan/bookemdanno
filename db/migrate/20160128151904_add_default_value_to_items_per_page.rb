class AddDefaultValueToItemsPerPage < ActiveRecord::Migration
  def change
    change_column_default(:users, :items_per_page, 5)
  end
end
