class Exam < ActiveRecord::Base
	has_and_belongs_to_many :problems

	# each quiz (exam) needs to have a title
	validates :title, presence: true

	accepts_nested_attributes_for :problems
	# attr_accessible :problem_ids
end
