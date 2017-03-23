class CreateComments < ActiveRecord::Migration
	def change
		create_table :comments do |t|
			t.references :post, index: true
			t.string :body
			t.integer :author, null:false
			t.timestamps
		end
	end
end
