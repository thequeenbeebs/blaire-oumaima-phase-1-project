class Gift < ActiveRecord::Base
    has_many :add_to_list
    has_many :wish_list, through: :add_to_list

    def edit
        puts "What would you like to change?"
        puts "1. Change Name"
        puts "2. Change Price"
        puts "3. Change Quantity"
        puts "4. Change Status"
        puts "5. Delete Gift"
        input = gets.chomp
        if input == "1"
            self.change_name
        elsif input == "2"
            self.change_price
        elsif input == "3"
            self.change_quantity
        elsif input == "4"
            self.change_status
        elsif input == "5"
            #delete gift method
        end
    end

    def change_name
        puts "What would you like to change the item's name to?"
        input = gets.chomp
        self.name = input
        self.list.homepage
    end

    def change_price
        puts "What would you like to change the item's price to?"
        input = gets.chomp
        self.price = input.to_f
        self.list.homepage
    end

    def change_quantity
        puts "What would you like to change the item's quantity to?"
        input = gets.chomp
        self.quantity = input.to_i 
        self.list.homepage
    end

    def change_status
        puts "Did you purchase this item? y/n"
        input = gets.chomp
        if input == "y"
            self.status = "Purchased"
            self.list.homepage
        elsif input == "n"
            self.edit
        end
    end




end