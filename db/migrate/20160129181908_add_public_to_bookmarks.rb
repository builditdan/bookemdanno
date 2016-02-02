class AddPublicToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :public, :boolean, default: false
  end
end
