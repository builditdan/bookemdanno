class UsersController < ApplicationController
before_action :authenticate_user!

  def show
    redirect_to (welcome_index_path) if current_user.blank?
    @user = current_user
    @no_topics = Topic.where(user_id: current_user.id).count
    @no_bookmarks = Topic.joins("LEFT OUTER JOIN bookmarks ON bookmarks.topic_id = topics.id").count

  end

  def new
	end

  #### end class
  end
