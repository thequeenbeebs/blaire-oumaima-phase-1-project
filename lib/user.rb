class User < ActiveRecord::Base
    has_many :list

    def profile_page
        prompt = TTY::Prompt.new
        puts
        input = prompt.select("#{self.username}'s Profile Page") do |option|
            option.choice "View My Lists"
            option.choice "Create A List"
            option.choice "Back to Home"
            option.choice "Exit"
        end
        if input == "View My Lists"
            self.view_lists
        elsif input == "Create A List"
            self.create_list
        elsif input == "Back to Home"
            CLI.run
        elsif input == "Exit"
            exit 
        end
    end

    def view_lists
        prompt = TTY::Prompt.new
        if self.list.length > 0
            puts
            input = prompt.select("#{self.username}'s Lists") do |option|
                self.list.each do |list|
                    option.choice list.name
                end 
            end
            list = List.find_by(name: input)
            self.list_homepage(list)
        else 
            puts
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
        self.list_homepage(new_list)
    end

    def list_homepage(list)
        puts
        puts list.name.bold
        puts "#{list.shopping_or_wish} List".italic
        list.gift.each do |gift|
            puts
            puts "Name: #{gift.name}"
            puts "Price: $#{sprintf "%.2f", gift.price}"
            puts "Quantity: #{gift.quantity}"
            puts "Status: #{gift.status}"
        end
        total = list.gift.sum {|gift| gift.price }
        puts
        puts "Total Cost: $#{sprintf "%.2f", total}"
        prompt = TTY::Prompt.new
        input =prompt.select("") do |option|
            option.choice "Add A Gift"
            option.choice "Edit Gift"
            option.choice "Delete List"
            option.choice "Back to Profile Page"
            #share list?
        end
        if input == "Add A Gift"
            list.add_gift
        elsif input == "Edit Gift"
            list.edit_gift_selector
        elsif input == "Delete List"
            list.delete_list
        elsif input == "Back to Profile Page"
            self.profile_page
        end
    end

    #def friend_list
      #view all lists your friends shared with you

end
