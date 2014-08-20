class Users < ActiveRecord::Migration
  def change
  
	add_column :users, :username, :string
	add_column :users, :password, :string
	add_column :users, :upvoted, :integer	
	add_column :users, :downvoted, :integer	

	add_column :groups, :identifier, :string

	add_column :posts, :content, :string		

	create_table :edits do |t|
      t.timestamps
    end
  end
end
