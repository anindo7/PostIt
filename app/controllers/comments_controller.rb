class CommentsController < ApplicationController
	before_action :require_user

	def create
		@post = Post.find(params[:post_id])
		@comment = Comment.new(comment_valid)
		@comment.post = @post
		@comment.user_id = session[:user_id]

		if @comment.save
			flash[:notice] = "Your comment was added!"
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end
	end

	def vote
		@comment = Comment.find(params[:id])
		@vote = Vote.create(vote: params[:type],user_id: session[:user_id],votable: @comment)

		if @vote.valid?
			flash[:notice] = "Your vote was recorded!"
		else
			flash[:error] = "You can only vote on a comment once."
		end
		redirect_to :back
	end

	def comment_valid
		params.require(:comment).permit(:body)
	end
end