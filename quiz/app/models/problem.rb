class Problem < ActiveRecord::Base
	has_and_belongs_to_many :aquizs
	# each Math Problem needs to have both a Question and an Answer
	validates :question, presence: true
	validates :answer, presence: true
end
