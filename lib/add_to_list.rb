class AddToList < ActiveRecord::Base
    belongs_to :list 
    belongs_to :gift
end