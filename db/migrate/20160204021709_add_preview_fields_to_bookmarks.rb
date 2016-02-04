class AddPreviewFieldsToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :embedly_url, :string
    add_column :bookmarks, :embedly_image_url, :string
    add_column :bookmarks, :embedly_descr, :string
    add_column :bookmarks, :embedly_title, :string
  end
end
