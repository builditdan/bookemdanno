include EmbedlyData
class BookmarksController < ApplicationController
before_action :authenticate_user!

  def new
    @bookmark = Bookmark.new
    @topic = Topic.find params[:topic_id]
    authorize(@bookmark)
  end

  def create
    @topic = Topic.find params[:topic_id]
    @bookmark = @topic.bookmarks.build(bookmark_params)
    if @bookmark.url.length >= 5
      hash = EmbedlyData.get_embedly_hash(@bookmark.url)
      @bookmark.embedly_url = hash[:embedly_url]
      @bookmark.embedly_image_url = hash[:embedly_image_url]
      @bookmark.embedly_descr = hash[:embedly_descr]
      @bookmark.embedly_title = hash[:embedly_title]
    end

    authorize(@bookmark)

    if @bookmark.save
      redirect_to topic_path(params[:topic_id]) , notice: "Bookmark was saved successfully."
    else
      flash.now[:alert] = "Error creating bookmark. Please try again."
      render :new
    end

  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)
    @bookmark.topic_id = params[:topic_id]

    hash = EmbedlyData.get_embedly_hash(@bookmark.url)
    @bookmark.embedly_url = hash[:embedly_url]
    @bookmark.embedly_image_url = hash[:embedly_image_url]
    @bookmark.embedly_descr = hash[:embedly_descr]
    @bookmark.embedly_title = hash[:embedly_title]

    authorize(@bookmark)

    if @bookmark.save
      redirect_to topic_path(params[:topic_id]), notice: "Bookmark was saved successfully."
    else
      flash.now[:alert] = "Error creating bookmark. Please try again."
      render :edit
    end

  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    @topic = Topic.find params[:topic_id]
    authorize(@bookmark)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize(@bookmark)
    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully along with associated bookmarks."
      redirect_to :back #topic_path(params[:topic_id])
    else
      flash.now[:alert] = "There was an error deleteing the bookmark."
      redirect_to :back
    end
  end


  def share_bookmark


      $bookmark = Bookmark.find(params[:id])
      $topic = Topic.find ($bookmark.topic_id)
      if $bookmark.public
        $bookmark.public = false
      else
        $bookmark.public = true
      end
      authorize($bookmark)
      if $bookmark.save
        update_topics_privacy
        redirect_to :back #topic_path($topic.id)
      else
        flash.now[:alert] = "Error creating topic. Please try again."
        redirect_to :back #topic_path($topic.id)
      end

  end

  def preview_bookmarks

    user = User.find(current_user.id)
    user.update_attribute(:preview_bookmark, !current_user.preview_bookmark)
    redirect_to :back

  end

  private

    def update_topics_privacy
      public_cnt = Bookmark.where(topic_id: $bookmark.topic_id, public: true).count
      topic = Topic.find ($bookmark.topic_id)
      if public_cnt == 0
        topic.public = false
      elsif $bookmark.public
        topic.public = true
      end
      if !topic.save
        flash.now[:alert] = "error update topic. Please try again."
      end
    end


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
