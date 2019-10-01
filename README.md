# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Attempting to do this using Rails 6.0

I changed the regex expression in the  devise.rb file to make it a more complete test of the 
valid email.

*psql commands
  command to view db: psql -d odin_facebook_development -U james -W
  then SELECT * FROM users;

  when it shows (end) just tap "q"

   rails db:migrate:reset deletes database


    rake routes | grep sessions  searches routes just for session routes

    should I put current user method in application helper or where
   

   edit_user_password is for an admin to change a password????

   make an option show show profile can be hidden users choice, maybe only friends can see?