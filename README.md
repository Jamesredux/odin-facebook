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



$ rails test
$ git add -A
$ git commit -m "Add user following"
$ git checkout master
$ git merge following-users
We can then push the code to the remote repository and deploy the application to production:

$ git push
$ git push heroku
$ heroku pg:reset DATABASE
$ heroku run rails db:migrate
$ heroku run rails db:seed



