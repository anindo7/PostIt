class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :votes,as: :votable

	validates :title, presence: true

	def total
		positive - negetive
	end

	def positive
		self.votes.where(vote: true).size
	end

	def negetive
		self.votes.where(vote: false).size
	end
end