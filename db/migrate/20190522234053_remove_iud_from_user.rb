class RemoveIudFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :iud
  end
end
