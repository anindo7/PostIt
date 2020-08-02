class CategoriesController < ApplicationController
	before_action :require_user
	
	def new
		@category = Category.new
	end

	def show
		@category = Category.find(params[:id])
	end

	def create
		@category = Category.new(category_valid)

		if @category.save
			flash[:notice]="Category was created successfully!"
			redirect_to root_path
		else
			render :new
		end
	end

	def category_valid
		params.require(:category).permit!
	end

end