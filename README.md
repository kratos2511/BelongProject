# README

# BelongProject
Item parsing using nokogiri, user login via Devise and rendering item to all user id not deleted

# Rails stack
ruby 2.5.1
Rails 5.2.0

# Important files
bin/pull_items_from_source.rb
* Can be used to schedule cron.
app/workers/item_parser_worker.rb
* Worker to fetch/update Item/Article from the Hacker News urls eg https://news.ycombinator.com/news?p=1
lib/item_creator.rb
* Implements how to get and parse items from the page
app/controllers/home_controller.rb
* Handles the landing page, Item listing of logged in user.
app/models/item.rb
* Item model, defines the Item in the application
app/models/user.rb
* Device generated user model. 
app/models/action_item.rb
* Important model which holds the relationship between User and Item. Used for tracking read and deleted items for User.
lib/home_util.rb
* A utility class to facilitate creation of action_item models for users.

Pending:
* Test case for unit testing.

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