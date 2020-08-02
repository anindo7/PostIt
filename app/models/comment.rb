class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	has_many :votes,as: :votable

	validates :body, presence: true

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