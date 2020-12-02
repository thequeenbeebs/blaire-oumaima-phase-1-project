class List < ActiveRecord::Base
    has_many :add_to_list
    has_many :gift, through: :add_to_list
    belongs_to :user

    def homepage
        puts self.name
        self.gift.each do |gift|
            puts
            puts "Name: #{gift.name}"
            puts "Price: $#{sprintf "%.2f", gift.price}"
            puts "Quantity: #{gift.quantity}"
            puts "Status: #{gift.status}"
        end
        total = self.gift.sum {|gift| gift.price }
        puts
        puts "Total Cost: $#{sprintf "%.2f", total}"
        puts
        puts "1. Add A Gift"
        puts "2. Edit Gift"
        #share list
        puts "3. Delete List"
        input = gets.chomp
        if input == "1"
            self.add_gift
        elsif input == "2"
            self.edit_gift_selector
        elsif input == "3"
            self.delete_list
        end
    end

    def add_gift
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
        self.homepage
    end

    def edit_gift_selector
        puts "Which item would you like to edit?"
        self.gift.each do |gift|
            puts
            puts gift.name
        end
        input = gets.chomp
        gift = Gift.find_by(name: input)
        gift.edit
    end

    # def share_list
    #     puts "Who would you like to share this list with?"
    #     input = gets.chomp
    #     friend = User.find_by(name: input)
    #     FriendsList.create(user_id: friend.id, friend: self.user.name, name: self.name, shopping_or_wish: self.shopping_or_wish how do i add the gifts though?)
    #     puts "We have shared your list with #{friend.name}"
    # end

    def delete_list
        puts "Are you sure you want to delete this list? y/n"
        input = gets.chomp
        if input == "y"
            self.destroy
            self.gift.destroy
            puts "This list has been deleted"
            self.user.profile_page
        elsif input == "n"
            self.homepage
        end
    end



end