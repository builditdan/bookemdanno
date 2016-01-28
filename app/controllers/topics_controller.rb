class TopicsController < ApplicationController

  def index

      @topics = Topic.show_5_to(current_user.id)
      if !@topics.blank?
        @last_id = Topic.show_to(current_user.id).last.id
        ipp = current_user.items_per_page

        if Topic.show_to(current_user.id).count <= ipp
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

  def next_5

    @next_offset = params[:next_offset].to_i
    @previous_offset = params[:previous_offset].to_i

    ipp = current_user.items_per_page
    if Topic.show_to(current_user.id).count <= ipp
      @enablenav = false
    else
      @enablenav = true
    end

    @last_id = Topic.show_to(current_user.id).last.id
    @topics = Topic.show_by_offset_to(current_user.id, @next_offset)
    if @last_id == @topics.last.id
      @previous_offset = @next_offset - ipp
      @next_offset = 0
    elsif @next_offset == 0
      @previous_offset = find_last_previous * ipp
      @next_offset = @next_offset + ipp
    else
      @previous_offset = @next_offset - ipp
      @next_offset = @next_offset + ipp
    end

  end

  def previous_5

    @next_offset = params[:next_offset].to_i
    @previous_offset = params[:previous_offset].to_i

    ipp = current_user.items_per_page
    if Topic.show_to(current_user.id).count <= ipp
      @enablenav = false
    else
      @enablenav = true
    end

    @last_id = Topic.show_to(current_user.id).last.id
    @topics = Topic.show_by_offset_to(current_user.id, @previous_offset)
    if @previous_offset == 0
      @next_offset = ipp
      @previous_offset = find_last_previous * ipp
    elsif @next_offset == ipp
      @next_offset = 0
      @previous_offset = @previous_offset - ipp
    else
      @previous_offset = @previous_offset - ipp
      @next_offset = @previous_offset + (ipp *2)
    end
  end

  def show
    @route_back_to = topic_path
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash.now[:alert] = "error creating topic. Please try again."
      render :new
    end

  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash.now[:alert] = "error creating topic. Please try again."
      render :edit
    end

  end

  def edit
      @topic = Topic.find(params[:id])
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted successfully along with associated bookmarks."
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error deleteing the topic."
      render :show
    end
  end

  private

    def find_last_previous
      ipp = current_user.items_per_page
      no_topics = Topic.show_to(current_user.id).count
      last_offset = no_topics / ipp
      last_offset -= 1 if no_topics % ipp == 0
      last_offset
    end

    def topic_params
      params.require(:topic).permit(:title, :user_id)
    end

end
