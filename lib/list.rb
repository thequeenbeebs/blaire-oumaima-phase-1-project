class List < ActiveRecord::Base
    has_many :add_to_list
    has_many :gift, through: :add_to_list
    belongs_to :user

    def homepage
        puts self.name
        self.all_gifts.each do |gift|
            puts "Name: #{gift.name}"
            puts "Price: $#{gift.price}"
            puts "Quantity: #{gift.quantity}"
        end
        total = self.gift.sum {|gift| gift.price }
        puts "Total Cost: $#{total}"
        puts "1. Add A Gift"
        puts "2. Edit Gift"
        puts "3. Delete List"
        input = gets.chomp
        if input == "1"
            self.add_gift
        elsif input == "2"
            #edit gift method
        elsif input == "3"
            #delete list method
        end
    end

    def all_gifts
        gift_ids = []
        AddToList.all.each do |i|
            if i.list_id == self
                gift_ids << i.gift_id
            end 
        end
        #find the gifts that coordinate with those ids
    end

    def add_gift
        puts "Add A Gift"
        puts "Name:"
        input_1 = gets.chomp
        puts "Price:"
        input_2 = gets.chomp.to_f
        puts "Quantity:"
        input_3 = gets.chomp.to_i 
        new_gift = Gift.create(name: input_1, price: input_2, quantity: input_3)
        AddToList.create(gift_id: new_gift.id, list_id: self.id)
        self.homepage
    end



end