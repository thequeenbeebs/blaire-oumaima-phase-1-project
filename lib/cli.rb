require "pry" 
class CLI 

    def self.run
        puts "Welcome to our badass APP!"
        puts "What would you like to do?"
        puts "1. Sign in or 2. Sign up"
        input = gets.chomp 
        if input == "1" 
            self.signin
        elsif input == "2" 
            self.signup
        end 
    end 

    def self.signin
        puts "Sign in here!"
        puts "Whats your username?"
        username = gets.chomp 
        account = User.find_by(username: username)
        if account == nil 
            puts "This account does not exist"
        else #else pull up profile of user 
    end 

    def self.signup 
        puts "Create an account here!"
        puts "What would you like your username to be?"
        username = gets.chomp
        account = User.find_by(username: username)
        if account == nil
            #create new user instance 
        


end 



#profile page 
#offer welcome message 
#create/ or view a list 

#create list method 
    #ask for a list name 
    #ask what type of list (wish or shopping list)
    #returns add a gift method 

#view list method 
    #show all lists available to that user
        #then user will select which list to view 
    #show list of gifts that have been added so far 
    #give options to add or remove gift options 
    #give options to view total cost of all gifts on said list 
    #option to delete the list 

#add gift method 
    #ask for name of gift 
    #ask for price of gift
    #ask for quantity of gift 

#remove gift method 
    #option to remove gift
    

#edit gift method 
    #allow user to know if gift has been purchased 
    #update price
    #update quantity 
