# To Do List
* create some sort of exit screen?
* formatting
* waiting to hear back from eBay API registration

# Module One Final Project Guidelines

Congratulations, you're at the end of module one! You've worked crazy hard to get here and have learned a ton.

For your final project, we'll be building a Command Line database application.

## Project Requirements

### Option One - Data Analytics Project

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have at minimum three models including one join model. This means you must have a many-to-many relationship.
3. You should seed your database using data that you collect either from a CSV, a website by scraping, or an API.
4. Your models should have methods that answer interesting questions about the data. For example, if you've collected info about movie reviews, what is the most popular movie? What movie has the most reviews?
5. You should provide a CLI to display the return values of your interesting methods.  
6. Use good OO design patterns. You should have separate classes for your models and CLI interface.

  **Resource:** [Easy Access APIs](https://github.com/learn-co-curriculum/easy-access-apis)

### Option Two - Command Line CRUD App

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate classes for your models and CLI interface.

## Instructions

1. Fork and clone this repository.
2. Build your application. Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable.
3. Make sure to create a good README.md with a short description, install instructions, a contributor's guide and a link to the license for your code.
4. Make sure your project checks off each of the above requirements.
5. Prepare a video demo (narration helps!) describing how a user would interact with your working project.
    * The video should:
      - Have an overview of your project. (2 minutes max)
6. Prepare a presentation to follow your video. (3 minutes max)
    * Your presentation should:
      - Describe something you struggled to build, and show us how you ultimately implemented it in your code.
      - Discuss 3 things you learned in the process of working on this project.
      - Address what, if anything, you would change or add to what you have today.
      - Present any code you would like to highlight.   
7. *OPTIONAL, BUT RECOMMENDED*: Write a blog post about the project and process.

---
### Common Questions:
- How do I turn off my SQL logger?
```ruby
# in config/environment.rb add this line:
ActiveRecord::Base.logger = nil
```


Phase 1 Project Proposal: Oumaima and Blaire

Name of App :  Amazon Holiday Gift Selector

Blurb : App offers Gift recommendations to Users based on price, age range, gender, etc.
User can then choose to add these Gift items to their Wish_List. Users can also purchase
from the Wish_List. 

User stories:

As a User, I want to receive recommendations for Gifts. #STRETCH
As a User, I want to be able to create a List. #CORE
As a User, I want to be able to add and remove Gifts from the List. #CORE
As a User, I want to purchase items on my List. #CORE

Send List to another user? #STRETCH

# Gift Cloud
## the holidays just got a bit easier.

Gift Cloud is a CLI application that can be used to create lists for all of your holiday gift-giving needs! Create a username, create the lists you need, and start adding gifts! This is a great way to get your shopping or wish lists organized and all of the information in one place. 

## Setup
In the root directory folder, type `bundle install` in the terminal to install all gems required, and then type `rake db:migrate` to set up the database tables. After that you should be good to go!

If you would like to play around with some pre-made data rather than creating your own lists, you can run `rake db:seed` in the terminal and the check out the db/seeds.rb file for reference.

## Getting Started
* Run `ruby bin/run.rb` to begin the program
* Choose from the selections on the home screen and get your shopping on!

## Models: Gift < Purchase > List

### Gift 
* has many :add_to_list
* has_many :list through :add_to_list

### Add_To_List
  belongs_to :gift
  belongs_to :list

### List
* has_many :add_to_list
* has_many :gift through :add_to_list

## List > User

### List
* belongs_to :user

### User
* has_many :list

