class TopicPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record

  end

  def filter?
    user_logged_in?
  end

  def next_5?
    user_logged_in?
  end

  def previous_5?
    user_logged_in?
  end

  def public?
    user_logged_in?
  end


end
