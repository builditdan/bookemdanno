class Bookmark < ActiveRecord::Base
  belongs_to :topic
  has_many :likes, dependent: :destroy
  default_scope { order('url ASC') }

  scope :show_bookmarks_filter, -> (filter) {

    if filter == "~LIKED"
      Bookmark.joins(:likes)
    else
      Bookmark.where("url LIKE ?", "%#{filter}%")
    end
  }


end
