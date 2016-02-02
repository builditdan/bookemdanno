class LikesController < ApplicationController

  def create
     @bookmark = Bookmark.find(params[:bookmark_id])
     like = current_user.likes.build(bookmark: @bookmark)
     authorize(like)
     if like.save
       #redirect_to topic_path(@bookmark.topic_id), notice: "Bookmark was liked successfully."
       redirect_to :back #, notice: "Bookmark was liked successfully."
     else
       flash.now[:alert] = "Error updating like. Please try again."
       redirect_to :back
     end

  end

  def destroy
     like = Like.find_by(bookmark_id: params[:bookmark_id])
     authorize(like)
     #if !policy(Like.new).destroy?
     #     byebug
     #     end


     if like.destroy
       redirect_to :back #, notice: "Bookmark was un-liked successfully."
     else
       flash.now[:alert] = "Error updating like. Please try again."
       redirect_to :back
     end
  end




end
