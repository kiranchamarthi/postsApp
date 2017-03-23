class PostsController < ApplicationController

	before_action :set_id, only: [:show,:edit,:update,:destroy]	

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params_values)
		@post.created_by = current_user.id
		@post.updated_by = current_user.id
		if @post.save
			redirect_to post_path(@post), notice: "Post created successfully"
		else
			render :new
		end
	end

	def show		
	end

	def edit		
	end

	def update		
		@post.assign_attributes(params_values)
		@post.updated_by = current_user.id
		if @post.save
			redirect_to post_path(@post), notice: "Post updated successfully"
		else
			render :new
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path, alert: "Post Deleted"
	end

	private
		def params_values
			params.require(:post).permit(:title, :body)
		end

		def set_id
			@post = Post.find_by_id(params[:id])
		end
end
