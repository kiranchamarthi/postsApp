require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

	describe "GET #index" do
		#index contoller method returns a list of post records,
		# so create a list and compare the populated listed with the list returned by the controller
		# setting up data
		it "blocks unauthenticated access" do
			
			get :index
		    
			expect(response).to redirect_to(new_user_session_path)
		end

		it "populates a list of posts" do
			sign_in
			FactoryGirl.create(:post)
			FactoryGirl.create(:post)
			get :index
		    assigns(:posts).size.should == 2
		end
	end

	describe "GET #new" do
		#new method builds an empty post object,build a new post object and compare it with the object returned from the controller
		it "creates a new post object for selected client" do
			post = Post.new
	 		get :new
	 		# Check whether new method just builds a new object for post
	 		assigns(:post) == post
		end
	end

	describe "POST #create" do
		context "with valid attributes" do
			#For all valid attributes as input the incomes table should increase its count by 1 on create
			it "saves the new post object in the database" do
				sign_in
				expect{ post :create, post: FactoryGirl.attributes_for(:post)
					  }.to change(Post,:count).by(1)
			end			
		end

		context "with invalid attributes" do
			#For any invalid attributes as input the create should not do any insertion and the count on the table should remain same
			it "will not save the post object in the database" do
				sign_in
				expect{ post :create, post: FactoryGirl.attributes_for(:invalid_post_data)
				      }.to_not change(Post,:count)
			end

			#For any invalid attributes as input the create should fail and render the new page
			it "re-renders the :new template when create is fails." do
				sign_in
				post :create, post: FactoryGirl.attributes_for(:invalid_post_data)
				response.should render_template :new
			end
		end
	end

	describe 'PUT #update' do
		before :each do
			@post = FactoryGirl.create(:post)
			sign_in
    	end
		context "valid attributes" do
			#For update action first we need to check whether the right record is being updated
			it "locate the post object to be updated" do
				put :update, id: @post, post: FactoryGirl.attributes_for(:post)
				assigns(:post).should == @post
			end

			#For valid attributes passed on update check whether the update is successful or not
			it "updates post object when valid attributes are passed" do
				put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: "New Title")
				# reload the variables - they should reflect the modified data.
				@post.reload
				# test
				@post.title.should == "New Title"
		    end

		   	# For all valid attributes as input on sucessuful update it should redirect to the show page
		    it "redirects to the show page after successful update" do
		    	put :update, id: @post ,post: FactoryGirl.attributes_for(:post,title: "New Title")
		    	response.should redirect_to @post
		    end
		end

		context "invalid attributes" do
			# For update action first we need to check whether the right record is being updated
			it "locates the requested @post" do
				put :update,id: @post, post: FactoryGirl.attributes_for(:invalid_post_data)
				assigns(:post).should == @post
			end

			#For all invalid attributes as input the update should fail and the object should persist it's previous data
			it "does not update post object when invalid attributes are passed." do
				put :update,id: @post, post: FactoryGirl.attributes_for(:invalid_post_data)
				@post.reload
				@post.title.should == "Post Title"
			end

			#For all invalid attributes as input the update should fail and render back to the update screen
			it "re-renders the edit method when update is failed." do
				put :update,id: @post, post: FactoryGirl.attributes_for(:invalid_post_data)
				response.should render_template :new
			end
		end
	end

	describe "DELETE #destroy" do
		before :each do
			@post = FactoryGirl.create(:post)
			sign_in
    	end

	    it "destroys the requested post record" do
	      expect {
	        delete :destroy, id: @post
	      }.to change(Post, :count).by(-1)
	    end	    

	    it "redirects to the posts index on successful delete" do
	      delete :destroy, id: @post
	      response.should redirect_to posts_path
	    end
	end
end
