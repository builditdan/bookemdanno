class BookmarksController < ApplicationController

  def new
    @bookmark = Bookmark.new
  end

  def create
    #@bookmark = Bookmark.build(bookmark_params)
    @topic = Topic.find params[:topic_id]
    @bookmark = @topic.bookmarks.build(bookmark_params)
    # Research why I can't get topic_id permitted
    #@bookmark.topic_id = params[:topic_id]
    if @bookmark.save
      redirect_to topic_path(params[:topic_id]), notice: "Bookmark was saved successfully."
    else
      flash.now[:alert] = "Error creating bookmark. Please try again."
      render :new
    end

  end

  def update
    @bookmark = Bookmark.find(params[:id])
    #url = add_http(params[:bookmark][:url])
    # Research why I can't get topic_id permitted
    @bookmark.assign_attributes(bookmark_params)
    @bookmark.topic_id = params[:topic_id]
    if @bookmark.save
      redirect_to topic_path(params[:topic_id]), notice: "Bookmark was saved successfully."
    else
      flash.now[:alert] = "Error creating bookmark. Please try again."
      render :edit
    end

  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully along with associated bookmarks."
      redirect_to topic_path(params[:topic_id])
    else
      flash.now[:alert] = "There was an error deleteing the bookmark."
      redirect_to :back
    end
  end

  private

    def bookmark_params
      params.require(:bookmark).permit(:url)
    end

    def add_http(link)
        u=URI.parse(link)
        if (!u.scheme)
            link = "http://" + link
        else
            link = link
        end
        #super(link)
    end


end
