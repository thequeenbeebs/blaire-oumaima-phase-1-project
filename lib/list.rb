class List < ActiveRecord::Base
    has_many :add_to_lists
    has_many :gifts, through: :add_to_lists
    belongs_to :user

    def add_gift
        puts
        puts "Add A Gift"
        puts
        puts "Name:"
        input_1 = gets.chomp
        puts "Price:"
        input_2 = gets.chomp.to_f 
        puts "Quantity:"
        input_3 = gets.chomp.to_i 
        new_gift = Gift.create(name: input_1, price: input_2, quantity: input_3, status: "Not Purchased")
        AddToList.create(gift_id: new_gift.id, list_id: self.id)
        puts
        prompt = TTY::Prompt.new
        input = prompt.select("Your gift has been added!") do |option|
            option.choice "Back to List"
            option.choice "Back to Profile Page"
        end
        if input == "Back to List"
            list = List.find(self.id)  
            list.user.list_homepage(list)
        elsif input == "Back to Profile Page" 
            self.user.profile_page
        end
    end

    def edit_gift_selector
        prompt = TTY::Prompt.new
        puts
        if self.gifts.length == 0
            puts "You don't have any gifts yet!"
            input = prompt.select("Would you like to add one?") do |option|
                option.choice "Yes"
                option.choice "No"
            end
            if input == "Yes"
                self.add_gift
            elsif input == "No"
                self.user.list_homepage(self)
            end
        else    
            input = prompt.select("Which item would you like to edit?") do |option|
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
        input = prompt.select("What would you like to change?") do |option|
            option.choice "Change Name"
            option.choice "Change Price"
            option.choice "Change Quantity"
            option.choice "Change Status"
            option.choice "Delete Gift"
        end
        if input == "Change Name"
            self.change_name(gift)
        elsif input == "Change Price"
            self.change_price(gift)
        elsif input == "Change Quantity"
            self.change_quantity(gift)
        elsif input == "Change Status"
            self.change_status(gift)
        elsif input == "Delete Gift"
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
        input = prompt.select("Are you sure you want to delete this list?") do |option|
            option.choice "Yes"
            option.choice "No"
        end
        if input == "Yes"
            self.destroy
            self.gifts.destroy
            puts
            puts "This list has been deleted"
            puts
            user = User.find(self.user.id)  
            user.profile_page
        elsif input == "No"
            self.user.list_homepage(self)
        end
    end

    #GIFT EDITING METHODS

    def change_name(gift)
        puts "What would you like to change the item's name to?"
        input = gets.chomp
        gift.update(name: input)
        list = List.find(self.id) 
        list.user.list_homepage(list)
    end

    def change_price(gift)
        puts "What would you like to change the item's price to?"
        input = gets.chomp
        gift.update(price: input.to_f)
        list = List.find(self.id) 
        list.user.list_homepage(list)
    end

    def change_quantity(gift)
        puts "What would you like to change the item's quantity to?"
        input = gets.chomp
        gift.update(quantity: input.to_i)
        list = List.find(self.id) 
        list.user.list_homepage(list)
    end

    def change_status(gift)
        prompt = TTY::Prompt.new
        input = prompt.select("Did you purchase this item?") do |option|
            option.choice "Yes"
            option.choice "No"
        end
        if input == "Yes"
            gift.update(status: "Purchased")
        elsif input == "No"
            gift.update(status: "Not Purchased")
        end
        list = List.find(self.id)  
        list.user.list_homepage(list)
    end

    def delete_gift(gift)
        prompt = TTY::Prompt.new
        input = prompt.select("Are you sure you want to delete this gift?") do |option|
            option.choice "Yes"
            option.choice "No"
        end
        if input == "Yes"
            joiner = AddToList.find_by(list_id: self.id, gift_id: gift.id)
            joiner.destroy
            gift.destroy
            puts
            puts "This gift has been deleted."
            puts
        elsif input == "No"
            puts
        end
        list = List.find(self.id) 
        list.user.list_homepage(list) 
    end


    



end