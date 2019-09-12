# README
Rails Shortener, just follow the instructions to get it working locally.

* Ruby version
  ruby-2.6.0
  rails-5.2.3

* System dependencies
  none

* Configuration
  run `bundle install`

* Database creation
  Run the seeds to see dummy data on database.
  `rake db:create`
  `rake db:migrate`
  `rake db:seed`

* How to run the test suite
  `rspec`

* Services (job queues, cache servers, search engines, etc.)
  * Sidekiq 

* Algorithm used to generate the random alphanumeric string `SecureRandom.base64(6).gsub("/","_").gsub(/=+$/,"")` it replaces some strings, it is not designed to be unique but thanks to the help of the database I can check if the string was already used or not, if it is used it will generate a new one.

