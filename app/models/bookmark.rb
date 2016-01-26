class Bookmark < ActiveRecord::Base
  belongs_to :topic #,  dependent: :destroy
  default_scope { order('updated_at DESC') }

  scope :show_bookmarks_to, -> (user) { Bookmark.where(user_id: user) }

end
