class AddProviderAndUidToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :iud, :string
  end
end
