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
    logger.info "Incoming subject: #{incoming_subject}"
    logger.info "Incoming urls: #{incoming_urls}"

    the_user = User.find_by(email:incoming_email)
    if the_user.blank?
      logger.warn "Not a valid user: #{incoming_email}, exiting"
      exit
    end

    topic = Topic.find_by(title:incoming_topic)
    if topic.blank?
      topic = Topic.create
      topic.title = incoming_topic
      topic.user_id = the_user.id
      if topic.save
         logger.info "New topic created #{topic.title}"
      else
         logger.warn "Unable to save topic #{incoming_topic}, no bookmarks will be stored, bummer!"
         exit
      end
    end

    incoming_urls.each { |a_url|
      bookmark = Bookmark.new
      #a_url = "FIX->#{a_url}" if !(a_url =~ URI::regexp)
      bookmark.url = a_url
      bookmark.topic_id = topic.id

      if bookmark.save
          logger.info "New bookmark created #{bookmark.url}"
      else
          logger.warn "Unable to save bookmark #{a_url}, bookmark not stored, bummer!"
      end
    }

    end

end
