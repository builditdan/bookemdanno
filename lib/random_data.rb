module RandomData

# Follow https://github.com/stympy/faker for more options
# Only use FAKER in DEV as could pose a security risk

 def random_name
     first_name = Faker::Name.first_name
     last_name = Faker::Name.last_name.capitalize
     "#{first_name} #{last_name}"
 end

 def random_email
   #{}"#{random_word}@#{random_word}.#{random_word}"
   Faker::Internet.email
 end

 def random_password
   Faker::Internet.password
 end

  def random_paragraph
    Faker::Hipster.paragraph
  end

  def random_sentence
    #Faker::Hacker.say_something_smart.capitalize
    Faker::Hipster.sentence.capitalize
  end

  def random_word
    Faker::Hipster.words(1)
  end

  def random_avatar_image
    Faker::Avatar.image
  end

  def random_user(low,high)
    rand(low...high)
  end

end
