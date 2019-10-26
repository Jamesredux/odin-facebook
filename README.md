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


Added Devise set up
must confirm email change
send confirmation email when password changed
added lockable to lock account after 10 unsucessful sign in attempts
*psql commands
  command to view db: psql -d odin_facebook_development -U james -W
  then SELECT * FROM users;

  when it shows (end) just tap "q"

   rails db:migrate:reset deletes database


    rake routes | grep sessions  searches routes just for session routes

    should I put current user method in application helper or where
   

   edit_user_password is for an admin to change a password????

   make an option show show profile can be hidden users choice, maybe only friends can see?


   create friendships with user.friendships.create or Friendship.create
   can list friends with user.friend_ids

   have 2 error message partials one in devise/shared/_error_messages and 
   one in shared/error_messages turn this into one
   

   What needs to be indexed?
A good rule of thumb is to create database indexes for everything that is referenced in the WHERE, HAVING and ORDER BY parts of your SQL queries.


the ajax button seems to work but only on the user show page