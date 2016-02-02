class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks
  validates :title, length: { minimum: 5, maximum: 300 }, presence: true
  #default_scope { order(' updated_at DESC, title ASC') }
  default_scope { order(' updated_at DESC, title ASC') }

  scope :show_by_offset_to, -> (user, offset_value, showing_public) {
    if showing_public
      topics = Topic.where(public: true)
      topics.limit(5).offset(offset_value)
    else
      topics = Topic.where(user_id: user)
      topics.limit(5).offset(offset_value)
    end
  }

  scope :show_5_to, -> (user, showing_public) {
    if showing_public
      topics = Topic.where(public: true)
      topics.limit(5)
    else
      topics = Topic.where(user_id: user)
      topics.limit(5)
    end

  }

  scope :show_to, -> (user, showing_public) {
    if showing_public
      topics = Topic.where(public: true)
    else
      topics = Topic.where(user_id: user)
    end
  }



end
