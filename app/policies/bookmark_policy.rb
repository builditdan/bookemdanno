class BookmarkPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record

  end

  def share_bookmark?
    user_owns_record_or_admin?
  end

private

  def user_owns_record_or_admin?

    user_id = Topic.where(id:record.topic_id).pluck(:user_id)
    if user_id[0] == user.id or user.admin?
      true
    else
      false
    end

  end


end
