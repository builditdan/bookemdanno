include RandomData

5.times do
   user = User.create!(
   name:     RandomData.random_name,
   email:    RandomData.random_email,
   password: RandomData.random_password,
   confirmed_at: Time.now
   )
 end

 users = User.all

 admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'admin'
)

standard = User.create!(
   name:     'Standard User',
   email:    'standard@example.com',
   password: 'password',
   confirmed_at: Time.now,
   role: 'standard'
 )

 premium = User.create!(
   name: 'Premium User',
   email: 'premium@example.com',
   password: 'password',
   confirmed_at: Time.now,
   role: 'premium'
 )

 #50.times do
  # item = Item.create!(
  # name:   RandomData.random_sentence,
#   user_id: RandomData.random_user(1, User.count)
   #)
#end

 puts "Seed finished"
 puts "#{User.count} users created"
 #puts "#{Item.count} to-do items created"
