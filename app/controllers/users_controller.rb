class UsersController < ApplicationController
	before_action :require_user,except: [:new,:create]
	before_action :setup, only: [:show,:edit,:update]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_valid)

		if @user.save
			flash[:notice] = "Your account was created successfully!"
			session[:user_id] = @user.id
			redirect_to root_path
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @user.update(user_valid)
			flash[:notice] = "Your profile was updated successfully!"
			redirect_to user_path(@user)
		else
			render :edit
		end
	end

	def user_valid
		params.require(:user).permit(:username,:password)
	end

	def setup
		@user = User.find(params[:id])
	end
end