class User < ActiveRecord::Base
    has_many :list

    def profile_page
        prompt = TTY::Prompt.new
        input = prompt.select("#{self.username}'s Profile Page") do |option|
            option.choice "View My Lists"
            option.choice "Create A List"
        end
        if input == "View My Lists"
            self.view_lists
        elsif input == "Create A List"
            self.create_list
        end
    end

    def view_lists
        prompt = TTY::Prompt.new
        if self.list.length > 0
            input = prompt.select("#{self.username}'s Lists") do |option|
                self.list.each do |list|
                    option.choice list.name
                end 
            end
            list = List.find_by(name: input)
            list.homepage
        else 
            puts "#{self.username}'s Lists"
            puts
            puts "You haven't created any lists!"
            response = prompt.select("Would you like to create one?") do |option|
                option.choice "Yes"
                option.choice "No"
            end
            if response == "Yes"
                self.create_list
            elsif response == "No"
                self.profile_page
            end
        end
    end

    def create_list
        puts "What would you like to name your list?"
        name = gets.chomp
        prompt = TTY::Prompt.new
        type = prompt.select("Is this a shopping list or a wish list?") do |option|
            option.choice "Shopping"
            option.choice "Wish"
        end
        new_list = List.create(name: name, shopping_or_wish: type, user_id: self.id)
        new_list.homepage
    end

    #def friend_list
      #view all lists your friends shared with you

end
