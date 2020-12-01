class ChangeListsColumns < ActiveRecord::Migration[5.2]
    def change 
        rename_column(:lists, :type, :shopping_or_wish)
    end
end