class List < ActiveRecord::Base
    has_many :add_to_list
    has_many :gift, through: :add_to_list
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
            self.user.list_homepage(self)
        elsif input == "Back to Profile Page"
            self.user.profile_page
        end
    end

    def edit_gift_selector
        prompt = TTY::Prompt.new
        puts
        if self.gift.length == 0
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
                self.gift.each do |gift|
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
            gift.change_name
        elsif input == "Change Price"
            gift.change_price
        elsif input == "Change Quantity"
            gift.change_quantity
        elsif input == "Change Status"
            gift.change_status
        elsif input == "Delete Gift"
            self.delete_gift(gift)
        end
    end

    # def share_list
    #     puts "Who would you like to share this list with?"
    #     input = gets.chomp
    #     friend = User.find_by(name: input)
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
            self.gift.destroy
            puts
            puts "This list has been deleted"
            puts
            self.user.profile_page
        elsif input == "No"
            self.user.list_homepage(self)
        end
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
            self.user.list_homepage(self)
        elsif input == "No"
            puts
            gift.edit
        end
    end



end