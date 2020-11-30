class CreateGifts < ActiveRecord::Migration[5.2]
    def change
        create_table :gifts do |t|
            t.string :name
            t.float :price
            t.integer :inventory
        end
    end
end