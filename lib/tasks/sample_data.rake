namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "John User",
						 email: "gotmilk@gmail.com",
						 password: "foobars2",
						 password_confirmation: "foobars2")
	admin.toggle!(:admin)
	admin.toggle!(:professor)
	admin.toggle!(:ta)
    make_users
	make_microposts
	make_relationships
	
	Course.create!(course_name: "CMSC424", 
				   semester: "Fall2012")
  end
  
  def make_users
	99.times do |n|
	  name = Faker::Name.name
	  email = "example-#{n+1}@railstutorial.org"
	  password = "password"
	  User.create!(name: name,
				   email: email,
				   password: password,
				   password_confirmation: password)
	end
  end
  
  def make_microposts
	users = User.all(limit: 6)
	50.times do
	  content = Faker::Lorem.sentence(5)
	  users.each { |user| user.microposts.create!(content: content) }
	end
  end
  
  def make_relationships
    users = User.all
	user = users.first
	followed_users = users[2..50]
	followers = users[3..40]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each { |follower| follower.follow!(user) }
  end
end