include RandomData

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

  200.times do
    bookmark = Bookmark.create!(
    url: RandomData.random_url,
    topic_id: RandomData.random_topic(1, Topic.count),
  )
  end

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Topic.count} topics created"
 puts "#{Bookmark.count} bookmarks created"
