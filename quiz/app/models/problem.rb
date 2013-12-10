class Problem < ActiveRecord::Base
	# each Math Problem needs to have both a Question and an Answer
	validates :question, presence: true
	validates :answer, presence: true
end
