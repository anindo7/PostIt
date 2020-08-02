class PostsController < ApplicationController
	before_action :setup, only: [:show,:edit,:update,:vote]
  before_action :require_user

  def index
  	@posts = Post.all
  end

  def show
  	@comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_valid)
  	@post.user_id = session[:user_id]

  	if @post.save
  		flash[:notice] = "New Post created successfully!"
  		redirect_to posts_path
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @post.update(post_valid)
  		flash[:notice] = "Post updated successfully!"
  		redirect_to posts_path
  	else
  		render :edit
  	end
  end

  def vote
    @vote = Vote.create(vote: params[:type],user_id: session[:user_id],votable: @post)

    if @vote.valid?
      flash[:notice] = "Your vote was recorded!"
    else
      flash[:error] = "You can only vote on a post once."
    end
    redirect_to :back
  end

  def post_valid
  	params.require(:post).permit(:title,:url,:description,category_ids: [])
  end

  def setup
  	@post = Post.find(params[:id])
  end

end
