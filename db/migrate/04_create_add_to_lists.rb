class CreateAddToLists < ActiveRecord::Migration[5.2]
    def change
        create_table :add_to_lists do |t|
            t.integer :gift_id
            t.integer :list_id
        end
    end
end