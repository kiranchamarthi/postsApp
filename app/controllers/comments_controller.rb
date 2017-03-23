class CommentsController < ApplicationController
	before_action :create_comment_struct
	before_action :set_id, only: [:show,:edit,:update,:destroy]

	def index
		@comment_struct.comments = @comment_struct.post.comments
	end

	def new
		@comment_struct.comment = @comment_struct.post.comments.new
	end

	def create
		@comment_struct.comment = @comment_struct.post.comments.new(params_values)
		@comment_struct.comment.author = current_user.id
		if @comment_struct.comment.save
			redirect_to post_comment_path(@comment_struct.post,@comment_struct.comment), notice: "Comment created successfully"
		else
			render :new
		end
	end

	def show		
	end

	def edit		
	end

	def update		
		@comment_struct.comment.assign_attributes(params_values)
		if @comment_struct.comment.save
			redirect_to post_comment_path(@comment_struct.post,@comment_struct.comment), notice: "Comment updated successfully"
		else
			render :edit
		end
	end

	def destroy
		@comment_struct.comment.destroy
		redirect_to post_comments_path(@comment_struct.post), alert: "Comment Deleted"
	end

	private
		def params_values
			params.require(:comment).permit(:body)
		end

		def set_id
			@comment_struct.comment = Comment.find_by_id(params[:id])
		end

		def create_comment_struct
			@comment_struct = CommentStruct.new
			@comment_struct.post = Post.find_by_id(params[:post_id])
		end
end

