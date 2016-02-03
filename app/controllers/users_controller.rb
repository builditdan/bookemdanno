class UsersController < ApplicationController
before_action :authenticate_user!

  def show
    redirect_to (welcome_index_path) if current_user.blank?
    @user = current_user
    @no_topics = Topic.where(user_id: current_user.id).count
    @no_bookmarks = Topic.joins("LEFT OUTER JOIN bookmarks ON bookmarks.topic_id = topics.id").count

    @showing_public = true
    @filter = "~LIKED"
    @next_offset = nil
    @previous_offset = nil
    #@topics = Topic.joins("LEFT OUTER JOIN bookmarks ON likes.user_id = topics.user_id")
    @topics = Topic.show_liked_to(current_user.id)

    #:show_liked_to, -> (user) {

    #index_topics
    #authorize(@topics)
    @enablenav = false



  end


  private

    def index_topics

      if @filter.nil?
         @topics = Topic.show_5_to(current_user.id, @showing_public)
       else
         @topics = Topic.show_to(current_user.id, @showing_public)
       end
      if !@topics.blank?
        @last_id = Topic.show_to(current_user.id, @showing_public).last.id
        ipp = current_user.items_per_page
        if Topic.show_to(current_user.id, @showing_public).count <= ipp
          @enablenav = false
        else
          @enablenav = true
        end

        @next_offset = current_user.items_per_page
        @previous_offset = find_last_previous * current_user.items_per_page
      else
        flash.now[:alert] = "No topics exist yet. Time to create them!"
      end
    end

  #### end class
  end
