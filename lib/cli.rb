require "pry" 
require 'colorize'

class CLI 

    def self.run
        puts "Welcome to our badass APP!".bold.red
        puts "What would you like to do?".italic.blue
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
        user = User.find_by(username: username)
        if user == nil 
            puts "This account does not exist"
        else 
            user.profile_page
        end
    end 

    def self.signup 
        puts "Create an account here!"
        puts "What would you like your username to be?"
        username = gets.chomp
        user = User.find_by(username: username)
        if user == nil
            user = User.create(username: username)
            user.profile_page
        else
            puts "This username already exists. Please choose a different username!"
        end
    end
        


end 


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
