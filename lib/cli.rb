require "pry" 
class CLI 

    def self.run
        puts "Welcome to our badass APP!"
        puts "What would you like to do?"
        puts "1. Sign in or 2. Sign up"
        input = gets.chomp 
        if input == "1" 
            self.sign_in
        elsif input == "2" 
            self.sign_up
        end 
    end 

    def self.sign_in
        puts "Sign in here!"
        puts "Whats your username?"
        username = gets.chomp 
        user = User.find_by(username: username)
        if user == nil 
            puts "This account does not exist!" 
            puts "Would you like to create one? y/n"
            response = gets.chomp
            if response == "y"
                self.sign_up
            elsif response == "n"
                self.run
            end
        else 
            user.profile_page
        end
    end 

    def self.sign_up 
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


#remove gift method 
    #option to remove gift
    

#edit gift method 
    #allow user to know if gift has been purchased 
    #update price
    #update quantity 
