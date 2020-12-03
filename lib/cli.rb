require "pry"
require 'colorize'
require "tty-prompt"



class CLI

    def self.run
        prompt = TTY::Prompt.new
        puts self.greeting
        puts 
        puts "                           the holidays just got a bit easier.                                    ".bold.red.on_white
        puts
        input = prompt.select("let's get started!".bold.red.on_white) do |option|
             
            option.choice "sign in".light_cyan
            option.choice "create new account".light_cyan
            option.choice "exit".italic.light_white
        end 

        if input == "sign in".light_cyan
            self.sign_in
        elsif input == "create new account".light_cyan
            self.sign_up
        elsif input == "exit".italic.light_white
            exit
        end
    end

    def self.sign_in
        prompt = TTY::Prompt.new
        puts 
        puts "Welcome Back!".italic.white 
        puts 
        puts "what's your username?".magenta
        username = gets.chomp
        user = User.find_by(username: username)
        if user == nil
            puts 
            puts "this account does not exist.".bold.white
            puts
            response = prompt.select("create an account?".red) do |option|
                option.choice "yes"
                option.choice "no"
            end
            if response == "yes"
                self.sign_up
            elsif response == "no"
                self.run
            end 
        else
            user.profile_page
        end
    end

    def self.sign_up
        puts
        puts "create an account here!".red
        puts
        puts "what would you like your username to be?".italic.white
        username = gets.chomp
        user = User.find_by(username: username)
        if user == nil
            user = User.create(username: username)
            user.profile_page
        else
            puts "this username already exists. please choose a different username.".yellow
            self.sign_up
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


