class LikePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record

  end

  def create?
    user_logged_in?
  end

  def destroy?
    user_logged_in?
  end


end
