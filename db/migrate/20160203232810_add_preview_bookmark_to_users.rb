class AddPreviewBookmarkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :preview_bookmark, :boolean
  end
end
