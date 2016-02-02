class AddPublicToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :public, :boolean, default: false
  end
end
