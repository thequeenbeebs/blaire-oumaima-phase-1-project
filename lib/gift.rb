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
        #need to take in input and create methods for each option
    end
end