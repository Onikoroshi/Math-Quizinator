class Exam < ActiveRecord::Base
  has_and_belongs_to_many :problems

  validates :title, presence: true

  accepts_nested_attributes_for :problems

  def problem_ids=(some_problem_ids)
    @exam.problems.clear
    some_problem_ids.each {
      |prob_id|
      @exam.problems << Problem.find(prob_id)
    }
  end
end
