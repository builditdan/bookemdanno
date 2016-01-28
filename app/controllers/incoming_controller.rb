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

    incoming_urls.delete_if {|url| url.include? "wrote:" }

    user = User.find_by(email:incoming_email)
    if user.blank?
      logger.warn "Not a valid user: #{incoming_email}, exiting and not adding any bookmarks"
    else
      incoming_urls.each { |a_url|
        bookmark = Bookmark.new
        #a_url = "FIX->#{a_url}" if !(a_url =~ URI::regexp)
        bookmark.url = a_url
        bookmark.topic_id = topic.id
        if !(a_url.include? "wrote:") && bookmark.save
            logger.info "New bookmark created #{a_url}"
        else
            logger.warn "Unable to save bookmark #{a_url}, bookmark not stored, bummer!"
        end
      }
    end


  end

end
