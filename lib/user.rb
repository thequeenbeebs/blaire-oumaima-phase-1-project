class User < ActiveRecord::Base
    has_many :lists



    def profile_page
        prompt = TTY::Prompt.new
        puts
        input = prompt.select("#{self.username}'s profile".white.bold) do |option|
            option.choice "view my lists"
            option.choice "create a list"
            option.choice "back to home"
            option.choice "exit".white.italic
        end
        if input == "view my lists"
            self.view_lists
        elsif input == "create a list"
            self.create_list
        elsif input == "back to home"
            CLI.run
        elsif input == "exit".white.italic 
            exit 
        end
    end

    def view_lists
        prompt = TTY::Prompt.new
        if self.lists.length > 0
            puts
            input = prompt.select("#{self.username}'s lists".light_magenta) do |option|
                self.lists.each do |list|
                    option.choice list.name
                end 
            end
            list = List.find_by(name: input)
            self.list_homepage(list)
        else 
            puts
            puts "#{self.username}'s lists".magenta
            puts
            puts "you haven't created any lists!"
            response = prompt.select("would you like to create one?") do |option|
                option.choice "yes".bold.italic
                option.choice "no".bold
            end
            if response == "yes"
                self.create_list
            elsif response == "no"
                self.profile_page
            end
        end
    end

    def create_list
        puts "what would you like to name your list?".magenta.bold
        name = gets.chomp
        prompt = TTY::Prompt.new
        type = prompt.select("is this a shopping list or a wish list?".bold.italic) do |option|
            option.choice "shopping"
            option.choice "wish"
        end
        new_list = List.create(name: name, shopping_or_wish: type, user_id: self.id)
        self.list_homepage(new_list)
    end

    def list_homepage(list)
        puts
        puts list.name.bold
        puts "#{list.shopping_or_wish} List".italic
        list.gifts.each do |gift|
            puts
            puts "Name: #{gift.name}".magenta 
            puts "Price: $#{sprintf "%.2f", gift.price}"
            puts "Quantity: #{gift.quantity}".magenta 
            puts "Status: #{gift.status}"
        end
        total = list.gifts.sum {|gift| gift.price }
        puts
        puts "Total Cost: $#{sprintf "%.2f", total}".magenta 
        prompt = TTY::Prompt.new
        input =prompt.select("") do |option|
            option.choice "add a gift"
            option.choice "edit gift"
            option.choice "delete list"
            option.choice "back to profile page".italic
            #share list?
        end
        if input == "add a gift"
            list.add_gift
        elsif input == "edit gift"
            list.edit_gift_selector
        elsif input == "delete list"
            list.delete_list
        elsif input == "back to profile page".italic
            self.profile_page
        end
    end

    #def friend_list
      #view all lists your friends shared with you

end

