module EmbedlyData

  def get_embedly_hash(url)

    embedly_api = Embedly::API.new :key => ENV['EMBEDLY_KEY'],
            :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    obj = embedly_api.extract :url => url
    #json_string = JSON.pretty_generate(obj[0].marshal_dump)
    data_hash = JSON.parse(JSON.pretty_generate(obj[0].marshal_dump))
    hash = {}

    hash[:embedly_url] = (data_hash["url"].blank? ? nil : data_hash["url"])
    hash[:embedly_image_url] = (data_hash["images"].blank? ? nil : data_hash["images"].first["url"])
    hash[:embedly_descr] = (data_hash["description"].blank? ? nil : data_hash["description"])
    hash[:embedly_title] = (data_hash["title"].blank? ? nil : data_hash["title"])

    return hash

  end


end
