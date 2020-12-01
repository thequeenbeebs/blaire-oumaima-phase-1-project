class List < ActiveRecord::Base
    has_many :add_to_list
    has_many :gift, through: :add_to_list
    belongs_to :user

    def homepage
        puts self.name
        #lists all gifts
        #add gift
        #edit gift 
        #view total price
        #delete list
    end
end