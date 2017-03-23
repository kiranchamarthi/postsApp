class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string  :title, null: false , limit: 35    	
    	t.string :body
    	t.integer :created_by , null:false
    	t.integer :updated_by , null:false
      	t.timestamps      
    end
  end
end
