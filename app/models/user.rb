class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :topics
  has_many :likes, dependent: :destroy


  before_save {
    self.email = email.downcase
    #convert name to a string
    temp = name.to_s
    #split name into words and then capitalize but only if a space exists
    self.name = temp.split(' ').map(&:capitalize).join(' ') if temp.match(/.\s./)
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: "encrypted_password.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 100 },
             format: { with: EMAIL_REGEX }


# if self role is not defined then default to a member role
  #before_save {self.role ||= :standard }
  after_initialize {self.role ||= :standard}

  #attr_accessible :email, :password, :name, :password_confirmation
  enum role: [:standard, :premium, :admin]


  def liked(bookmark)
     Like.where(bookmark_id: bookmark.id).first
  end



end
