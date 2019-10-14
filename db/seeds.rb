# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Create a main sample user

User.create!(name: "James Redux",
							email: "jamesredux@gmail.com",
							password: "foobar",
							password_confirmation: "foobar",
							admin: true,
							confirmed_at: Time.zone.now )

# Generate a bunch of additional users.
99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@odinfacebook.com"	
	password = "password"
	User.create!(name: name,
								email: email,
								password:  password,
								password_confirmation: password,
								confirmed_at: Time.zone.now)
end														


#posts

users = User.order(:created_at).take(6)
50.times do 
	content = Faker::TvShows::TwinPeaks.quote
	users.each { |user| user.posts.create!(content: content) }
end	