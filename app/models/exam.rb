class Exam < ActiveRecord::Base
  has_and_belongs_to_many :problems

  validates :title, presence: true

  accepts_nested_attributes_for :problems

  def problem_ids=(some_problem_ids)
    self.problems.clear
    some_problem_ids.each {
      |prob_id|
      self.problems << Problem.find(prob_id)
    }
  end

  def score(some_answers)
    results = []
    score = 0

    some_answers.each_with_index {
      |ans, index|
      prob = self.problems[index] # find the problem that goes with this answer
      if ans == prob.answer
        score += 1
        results << [prob.question, prob.answer, "", false]
      else
        results << [prob.question, prob.answer, ans, true]
      end
    }

    return score, results
  end
end
