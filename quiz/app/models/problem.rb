class Problem < ActiveRecord::Base
	has_and_belongs_to_many :exams
	
	# each Math Problem needs to have both a Question and an Answer
	validates :question, presence: true
	validates :answer, presence: true

	accepts_nested_attributes_for :exams
	# accepts_nested_attributes_for :exams_problems
	# attr_accessible :exam_ids
end
