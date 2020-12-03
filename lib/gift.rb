class Gift < ActiveRecord::Base
    has_many :add_to_lists
    has_many :wish_lists, through: :add_to_lists


   

    # def status
    #     if self.status == nil
    #         self.status = "Not Purchased"
    #     end
    # end


end