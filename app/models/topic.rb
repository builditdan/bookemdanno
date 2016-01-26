class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks
  validates :title, length: { minimum: 5, maximum: 300 }, presence: true
  default_scope { order(' updated_at DESC, title ASC') }

  scope :show_by_offset_to, -> (user, offset_value) {
    topics = Topic.where(user_id: user)
    topics.limit(5).offset(offset_value)
  }

  scope :show_5_to, -> (user) {
    topics = Topic.where(user_id: user)
    topics.limit(5)
  }

  scope :show_to, -> (user) {
    topics = Topic.where(user_id: user)
  }

end
