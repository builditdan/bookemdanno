class TopicPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record

  end

  def filter?
    true
  end

  def next_5?
    true
  end

  def previous_5?
    true
  end

  def public?
    true
  end

  private

  def user_owns_record_or_admin?

    if record.user_id == user.id or user.admin?
      true
    else
      false
    end

  end
end
