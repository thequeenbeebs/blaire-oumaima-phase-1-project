class List < ActiveRecord::Base
    has_many :add_to_lists
    has_many :gifts, through: :add_to_lists
    belongs_to :user

    def add_gift
        puts
        puts "add a gift!".bold.white
        puts
        puts "Name:".italic.magenta 
        input_1 = gets.chomp
        puts "Price:".italic.magenta
        input_2 = gets.chomp.to_f 
        puts "Quantity:".italic.magenta
        input_3 = gets.chomp.to_i 
        new_gift = Gift.create(name: input_1, price: input_2, quantity: input_3, status: "Not Purchased")
        AddToList.create(gift_id: new_gift.id, list_id: self.id)
        puts
        prompt = TTY::Prompt.new
        input = prompt.select("your gift has been added!".bold.white) do |option|
            option.choice "back to list".light_magenta
            option.choice "back to profile page".light_magenta 
        end
        if input == "back to list".light_magenta
            list = List.find(self.id)  
            list.user.list_homepage(list)
        elsif input == "back to profile page".light_magenta 
            self.user.profile_page
        end
    end

    def edit_gift_selector
        prompt = TTY::Prompt.new
        puts
        if self.gifts.length == 0
            puts "you don't have any gifts yet!".magenta
            input = prompt.select("would you like to add one?") do |option|
                option.choice "yes".italic
                option.choice "no".bold
            end
            if input == "yes".italic
                self.add_gift
            elsif input == "no".bold
                self.user.list_homepage(self)
            end
        else    
            input = prompt.select("which item would you like to edit?".light_magenta) do |option|
                self.gifts.each do |gift|
                    option.choice gift.name
                end
            end
            gift = Gift.find_by(name: input)
            self.edit_gift_menu(gift)
        end
    end

    def edit_gift_menu(gift)
        prompt = TTY::Prompt.new
        puts
        input = prompt.select("what would you like to change?".light_magenta) do |option|
            option.choice "change name"
            option.choice "change price"
            option.choice "change quantity"
            option.choice "change status"
            option.choice "delete gift"
        end
        if input == "change name"
            self.change_name(gift)
        elsif input == "change price"
            self.change_price(gift)
        elsif input == "change quantity"
            self.change_quantity(gift)
        elsif input == "change status"
            self.change_status(gift)
        elsif input == "delete gift"
            self.delete_gift(gift)
        end
    end

    # def share_list
    #     puts "Who would you like to share this list with?"
    #     input = gets.chomp
    #     friend = User.find_by(username: input)
    #     FriendsList.create(user_id: friend.id, friend: self.user.name, name: self.name, shopping_or_wish: self.shopping_or_wish how do i add the gifts though?)
    #     puts "We have shared your list with #{friend.name}"
    # end

    def delete_list
        puts
        prompt = TTY::Prompt.new
        input = prompt.select("are you sure you want to delete this list?".italic.yellow) do |option|
            option.choice "yes".italic
            option.choice "no".bold
        end
        if input == "yes".italic
            self.destroy
            self.gifts.destroy
            puts
            puts "this list has been deleted".yellow
            puts
            user = User.find(self.user.id)  
            user.profile_page
        elsif input == "no".bold 
            self.user.list_homepage(self)
        end
    end

    #GIFT EDITING METHODS

    def change_name(gift)
        puts "what would you like to change the item's name to?".bold.light_magenta
        input = gets.chomp
        gift.update(name: input)
        list = List.find(self.id) 
        list.user.list_homepage(list)
    end

    def change_price(gift)
        puts "what would you like to change the item's price to?".bold.light_magenta
        input = gets.chomp
        gift.update(price: input.to_f)
        list = List.find(self.id) 
        list.user.list_homepage(list)
    end

    def change_quantity(gift)
        puts "what would you like to change the item's quantity to?".bold.light_magenta
        input = gets.chomp
        gift.update(quantity: input.to_i)
        list = List.find(self.id) 
        list.user.list_homepage(list)
    end

    def change_status(gift)
        prompt = TTY::Prompt.new
        input = prompt.select("was this item purchased?".bold.light_magenta) do |option|
            option.choice "yes".italic
            option.choice "no"
        end
        if input == "yes".italic
            gift.update(status: "purchased".bold.light_magenta)
        elsif input == "no"
            gift.update(status: "not purchased".light_magenta)
        end
        list = List.find(self.id)  
        list.user.list_homepage(list)
    end

    def delete_gift(gift)
        prompt = TTY::Prompt.new
        input = prompt.select("are you sure you want to delete this gift?".italic.yellow) do |option|
            option.choice "yes".italic
            option.choice "no".bold
        end
        if input == "yes"
            joiner = AddToList.find_by(list_id: self.id, gift_id: gift.id)
            joiner.destroy
            gift.destroy
            puts
            puts "this gift has been deleted.".yellow
            puts
        elsif input == "no".bold
            puts
        end
        list = List.find(self.id) 
        list.user.list_homepage(list) 
    end


    



end