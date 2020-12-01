class ChangeGiftsColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column(:gifts, :inventory, :quantity)
  end
end
