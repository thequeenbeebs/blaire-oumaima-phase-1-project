class AddGiftsColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :gifts, :status, :string
  end
end
