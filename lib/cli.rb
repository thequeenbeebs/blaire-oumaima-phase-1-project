require "pry"
require 'colorize'
require "tty-prompt"



class CLI

    def self.run
        prompt = TTY::Prompt.new
        puts self.greeting
        puts 
        puts "                           the holidays just got a bit easier.                                    ".red
        puts
        input = prompt.select("Lets get started!") do |option|
            option.choice "Sign In"
            option.choice "Create New Account"
            option.choice "Exit"
        end 

        if input == "Sign In"
            self.sign_in
        elsif input == "Create New Account"
            self.sign_up
        elsif input == "Exit"
            exit
        end
    end

    def self.sign_in
        prompt = TTY::Prompt.new
        puts 
        puts "Welcome Back!".bold.red
        puts 
        puts "Whats your username?".italic.white
        username = gets.chomp
        user = User.find_by(username: username)
        if user == nil
            puts 
            puts "This account does not exist.".bold.white
            puts
            response = input = prompt.select("Create An Account".red) do |option|
                option.choice "Yes"
                option.choice "No"
            if response == "Yes"
                self.sign_up
            elsif response == "No"
                self.run
            end 
            end
        else
            user.profile_page
        end
    end

    def self.sign_up
        puts "Create An Account Here!".red
        puts
        puts "What would you like your username to be?".italic.white
        username = gets.chomp
        user = User.find_by(username: username)
        if user == nil
            user = User.create(username: username)
            user.profile_page
        else
            puts "This username already exists. Please choose a different username.".bold.yellow
        end
    end



    def self.greeting
    puts  "                      ______________________   ________    _______  ________                " 
    puts "                     / ____/  _/ ____/_  __/  / ____/ /   / __ \/ / / / __ \               "
    puts "                    / / __ / // /_    / /    / /   / /   / / // / / / / / /               "
    puts "                   / /_/ // // __/   / /    / /___/ /___/ /_// /_/ / /_/ /                "
    puts "                    \____/___/_/     /_/    \  ____/_____/\____/\_____/_____/                 "  
                                                          
 
    end 
end 


