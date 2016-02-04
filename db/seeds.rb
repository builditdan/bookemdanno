include RandomData, EmbedlyData

 5.times do
     user = User.create!(
     name:     RandomData.random_name,
     email:    RandomData.random_email,
     password: RandomData.random_password,
     confirmed_at: Time.now,
     items_per_page: 5
     )
 end

 users = User.all

 admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'admin',
  items_per_page: 5
)

standard = User.create!(
   name:     'Standard User',
   email:    'standard@example.com',
   password: 'password',
   confirmed_at: Time.now,
   role: 'standard',
   items_per_page: 5
 )

 premium = User.create!(
   name: 'Premium User',
   email: 'premium@example.com',
   password: 'password',
   confirmed_at: Time.now,
   role: 'premium',
   items_per_page: 5
 )

 #50.times do
  # item = Item.create!(
  # name:   RandomData.random_sentence,
#   user_id: RandomData.random_user(1, User.count)
   #)
#end

  52.times do
   topic = Topic.create!(
     title:   RandomData.random_sentence,
     user_id: RandomData.random_user(1, User.count)
  )
  end

  300.times do
    fake_url = RandomData.random_url
    hash = EmbedlyData.get_embedly_hash(fake_url)

    bookmark = Bookmark.create!(
    url: fake_url,
    topic_id: RandomData.random_topic(1, Topic.count),
    embedly_url: hash[:embedly_url],
    embedly_image_url: hash[:embedly_image_url],
    embedly_descr: hash[:embedly_descr],
    embedly_title: hash[:embedly_title]

  )
  end

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Topic.count} topics created"
 puts "#{Bookmark.count} bookmarks created"
