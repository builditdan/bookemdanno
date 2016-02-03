require 'embedly'
require 'json'

module UserHelper

  def display(url)
    embedly_api = Embedly::API.new(key: ENV['EMBEDLY_KEY'])
    obj = embedly_api.oembed :url => url
    (obj.first.html).html_safe
  end


  def display2(url)
    embedly_api = Embedly::API.new :key => ENV['EMBEDLY_KEY'],
            :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    url = 'http://www.guardian.co.uk/media/2011/jan/21/andy-coulson-phone-hacking-statement'
    obj = embedly_api.extract :url => url
    JSON.pretty_generate(obj[0].marshal_dump)

  end

  def display3(url)
    embedly_api =Embedly::API.new(key: ENV['EMBEDLY_KEY'])
    obj = embedly_api.extract :url => url
    #obj.html
    JSON.pretty_generate(obj[0].marshal_dump)
  end


end
