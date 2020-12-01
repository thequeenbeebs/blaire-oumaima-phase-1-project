class User < ActiveRecord::Base
    has_many :list

    def profile_page
        puts "#{self.username}'s Profile Page"
        puts "1. View My Lists"
        puts "2. Create A List"
        input = gets.chomp
        if input == "1"
            self.view_lists
        elsif input == "2"
            self.create_list
        end
    end

    def view_lists
        puts "#{self.username}'s Lists"
        all_lists = List.where("user_id == ?", self.id)
        if self.list.length == 0
            puts "You haven't created any lists yet!"
            puts "Would you like to create one? y/n"
            response = gets.chomp
            if response == "y"
                self.create_list
            elsif response == "n"
                self.profile_page
            end
        else
            puts "Which list would you like to view?"
            self.list.each do |list|
                puts list.name
            end 
            input = gets.chomp
            list = List.find_by(name: input)
            list.homepage
        end
        
    end

    def create_list
        puts "What would you like to name your list?"
        name = gets.chomp
        puts "Is this a shopping list or a wish list?"
        type = gets.chomp
        new_list = List.create(name: name, shopping_or_wish: type, user_id: self.id)
        new_list.homepage
    end

end