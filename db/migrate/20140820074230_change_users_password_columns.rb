class ChangeUsersPasswordColumns < ActiveRecord::Migration
  def change
  		remove_column :users, :password, :string
  		add_column :users, :password_hash, :string
  		add_column :users, :password_salt, :string
  end
end
