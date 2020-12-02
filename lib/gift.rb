class Gift < ActiveRecord::Base
    has_many :add_to_list
    has_many :wish_list, through: :add_to_list


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
        prompt = TTY::Prompt.new
        input = prompt.select("Did you purchase this item?") do |option|
            option.choice "Yes"
            option.choice "No"
        end
        if input == "Yes"
            self.status = "Purchased"
            self.list.homepage
        elsif input == "No"
            self.status = "Not Purchased"
            self.list.homepage
        end
    end


    # def status
    #     if self.status == nil
    #         self.status = "Not Purchased"
    #     end
    # end


end