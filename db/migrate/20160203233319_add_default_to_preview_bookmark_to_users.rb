class AddDefaultToPreviewBookmarkToUsers < ActiveRecord::Migration
  def change
    change_column_default(:users, :preview_bookmark, true)
  end
end
