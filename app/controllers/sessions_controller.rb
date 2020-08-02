class SessionsController < ApplicationController

	def create
		user = User.find_by(username: params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:notice] = "You logged in successfully!"
			redirect_to root_path
		else
			flash[:error] = "Could not log in. Try again!"
			render :new
		end
	end

	def destroy
		session[:user_id]=nil
		flash[:notice] = "You logged out successfully!"
		redirect_to login_path
	end

end