# Gift Cloud
## the holidays just got a bit easier.

Oumaima Azzat and Blaire Baker

Gift Cloud is a CLI application that can be used to create lists for all of your holiday gift-giving needs! Create a username, create the lists you need, and start adding gifts! This is a great way to get your shopping or wish lists organized and have all of the information in one place. 

## Setup

In the root directory folder, type `bundle install` in the terminal to install all gems required, and then type `rake db:migrate` to set up the database tables. After that you should be good to go!

If you would like to play around with some pre-made data rather than creating your own lists, you can run `rake db:seed` in the terminal and the check out the db/seeds.rb file for reference.

## Getting Started

* Run `ruby bin/run.rb` to begin the program
* Choose from the selections on the home screen and get your shopping on!

## Models: 

## Gift < Purchase > List

### Gift 
* has many :add_to_lists
* has_many :lists through :add_to_lists

### Add_To_List
  belongs_to :gift
  belongs_to :list

### List
* has_many :add_to_lists
* has_many :gifts through :add_to_lists

## List > User

### List
* belongs_to :user

### User
* has_many :lists

## User > Follow < User

### User
* has_many :followers through :follows
* has_many :followees through :follows

### Follow
* belongs_to :follower (user)
* belongs_to :folowee (user)

. 

User stories:

As a User, I want to receive recommendations for Gifts. #STRETCH
As a User, I want to be able to create a List. #CORE
As a User, I want to be able to add and remove Gifts from the List. #CORE
As a User, I want to purchase items on my List. #CORE

Send List to another user? #STRETCH


