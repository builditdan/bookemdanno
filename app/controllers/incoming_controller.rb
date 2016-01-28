require "uri"

class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]
  #before_action :authenticate_user!, except: [:create]

  def create
    puts "INCOMING PARAMS HERE: #{params}"
    logger.info "***********************************"
    logger.info "body:#{params[:"body-plain"]}"
    logger.info "subject:#{params[:subject]}"
    logger.info "email:#{params[:sender]}"
    logger.info "***********************************"

    incoming_urls = URI.extract(params[:"body-plain"])
    incoming_topic =  params[:subject]
    incoming_email =  params[:sender]

    logger.info "Incoming sender: #{incoming_email}"
    logger.info "Incoming subject: #{incoming_topic}"
    logger.info "Incoming urls: #{incoming_urls}"

    incoming_urls.delete_if {|url| (url.include? "wrote:") || (!url.include? "http") }

    if incoming_email.nil?
      logger.info "No email provided, exiting"
      return head 401 #:Unauthorized
    end

    if incoming_urls.nil?
      logger.info "No urls found, exiting"
      return head 200 #:ok
    end

    user = User.find_by(email:incoming_email)
    if user.blank?
      logger.info "Not a valid user: #{incoming_email}, exiting"
      return head 401 #:Unauthorized
    end

    logger.info "Checking topics now!!!!!"

    incoming_topic = "Email submitted url with no topic as of #{Time.new}" if incoming_topic.nil?

    topic = Topic.find_by(title:incoming_topic)
    if topic.blank?
      topic = Topic.create
      topic.title = incoming_topic
      topic.user_id = user.id
      if topic.save
         logger.info "New topic created #{topic.title}"
      else
         logger.info "Unable to save topic #{incoming_topic}, no bookmarks will be stored, bummer!"
         return head 500 # :internal_server_error
      end

    end

    incoming_urls.each { |a_url|
      bookmark = Bookmark.new
      #if !(a_url =~ URI::regexp)
      bookmark.url = a_url
      bookmark.topic_id = topic.id
      if bookmark.save
          logger.info "New bookmark created #{a_url}"
      else
          logger.info "Unable to save bookmark #{a_url}, bookmark not stored, bummer!"
      end
    }

    head 200 #:ok

  end



end
