class List < ActiveRecord::Base
    has_many :add_to_list
    has_many :gift, through: :add_to_list
    belongs_to :user

    def homepage
        puts self.name
        self.gift.each do |gift|
            puts "Name: #{gift.name}"
            puts "Price: $#{gift.price}"
            puts "Quantity: #{gift.quantity}"
        end
        total = self.gift.sum {|gift| gift.price }
        puts "Total Cost: #{total}"
        puts "1. Add A Gift"
        puts "2. Edit Gift"
        puts "3. Delete List"
        #lists all gifts
        #add gift
        #edit gift 
        #view total price
        #delete list
    end
end