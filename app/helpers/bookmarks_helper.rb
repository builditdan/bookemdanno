require 'embedly'
require 'json'
module BookmarksHelper

  def display_card(url)
    html_string = '<blockquote class="embedly-card" data-card-align="left" ><h4><a href="' + url + '"></h4></blockquote>'
    return html_string.html_safe
  end

   def real_time_custom_display_card(url)

     embedly_api = Embedly::API.new :key => ENV['EMBEDLY_KEY'],
             :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
     obj = embedly_api.extract :url => url
     #json_string = JSON.pretty_generate(obj[0].marshal_dump)
     data_hash = JSON.parse(JSON.pretty_generate(obj[0].marshal_dump))
     if !data_hash["images"].blank?
       #data_hash["favicon_url"]
       hash_url = (data_hash["url"].blank? ? url : data_hash["url"])
       hash_image_url = (data_hash["images"].blank? ? "broken.png" : data_hash["images"].first["url"])
       hash_descr = (data_hash["description"].blank? ? "Missing description" : data_hash["description"])
       hash_title = (data_hash["title"].blank? ? "Missing title" : data_hash["title"])

       build_html = '<h3>' + hash_title + '</h3>'
       build_html += '<blockquote>'
       build_html += '<a href="' + hash_url + '"><img src="' + hash_image_url + '" width="125" height="100" style="float:left; padding-right:10px;"></a> <br>'
       build_html += '<p>' + hash_descr + '</p>'
       build_html += '<footer> Read this is on ' + hash_url + ' </footer>'
       build_html += '</blockquote>'
    else
      build_html = '&nbsp;'
    end

     return build_html.html_safe

   end

   def from_db_custom_display_card(bookmark_id)

     bookmark = Bookmark.find(bookmark_id)

     if !bookmark.embedly_image_url.nil?
       build_html = '<h3>' + bookmark.embedly_title + '</h3>'
       build_html += '<blockquote>'
       build_html += '<a href="' + bookmark.embedly_url + '"><img src="' + bookmark.embedly_image_url + '" width="125" height="100" style="float:left; padding-right:10px;"></a> <br>'
       build_html += '<p>' + bookmark.embedly_descr + '</p>'
       build_html += '<footer> Read this is on <a href="' + bookmark.embedly_url + '">' + bookmark.embedly_url + '</a></footer>'
       build_html += '</blockquote>'
     else
       build_html = "<h3>Preview not available</h3>"
     end

     return build_html.html_safe

   end




  def display_video(url)
    embedly_api = Embedly::API.new(key: ENV['EMBEDLY_KEY'])
    obj = embedly_api.oembed :url => url
    (obj.first.html).html_safe
  end


  def display_json(url)
    embedly_api = Embedly::API.new :key => ENV['EMBEDLY_KEY'],
            :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    obj = embedly_api.extract :url => url
    json_string = JSON.pretty_generate(obj[0].marshal_dump)
    json_string
  end


end

#Now, the variable data_hash will be consisting of hash from which we can access values as,
    #data_hash['title']
    # => "Ruby In Rails"
    #data_hash.keys
    # => ["title", "url", "posts"]
    #data_hash['posts']

# Example keys returned from embedly after converting to a hash
   #["provider_url", "description", "embeds", "safe", "provider_display", "related", "favicon_url",
   # "authors", "images", "cache_age", "language", "app_links", "original_url", "url", "media", "title",
   # "offset", "lead", "content", "entities", "favicon_colors", "keywords", "published", "provider_name", "type"]
   #>>
   # Helpfuly link http://www.garrettqmartin.com/2015/02/03/finding-deeply-nested-hash-keys/

# Additional examples
    #<blockquote class="embedly-card" data-card-key="b7a2f554b735415ca1534d7440351fd2" data-card-chrome="0" data-card-type="article" data-card-align="left"><h4><a href="' + url + '"></blockquote>
    #http://www.msn.com/
    # Include the line below in app/views/layouts/application.html.erb so js is loaded
    #     <script async src="//cdn.embedly.com/widgets/platform.js" charset="UTF-8"></script>

    # <blockquote class="embedly-card" data-card-key="b7a2f554b735415ca1534d7440351fd2" data-card-chrome="0" data-card-type="article" data-card-align="left"><h4><a href="http://www.msn.com">MSN.com - Hotmail, Outlook, Skype, Bing, Latest News, Photos & Videos</a></h4><p>The new MSN, Your customizable collection of the best in news, sports, entertainment, money, weather, travel, health, and lifestyle, combined with Outlook, Facebook, Twitter, Skype, and more.</p></blockquote>
     # <script async src="//cdn.embedly.com/widgets/platform.js" charset="UTF-8"></script>
