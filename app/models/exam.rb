class Exam < ActiveRecord::Base
  has_and_belongs_to_many :problems

  validates :title, presence: true

  accepts_nested_attributes_for :problems

  def possible_operators
    ["+", "-", "*"]
  end

  class Result
    def initialize(problem, user_answer)
      @problem = problem
      @given_answer = user_answer
    end

    def worth
      return @problem.worth
    end

    def score
      return @problem.score(user_answer)
    end

    def question
      return @problem.question
    end

    def correct_answer
      return @problem.answer
    end

    def user_answer
      return @given_answer
    end
  end

  class Reporter
    def initialize(exam, user_answers)
      @exam = exam
      @results = []

      @exam.problems.each {
        |current_problem|
        puts user_answers
        @results << Result.new(current_problem, user_answers[current_problem.id.to_s])
      }
    end

    def score
      return @results.inject(0) {
        |score_so_far, current_result|
        score_so_far + current_result.score
      }
    end

    def total_possible
      return @results.inject(0) {
        |total_so_far, current_result|
        total_so_far + current_result.worth
      }
    end

    def results
      return @results
    end
  end

  def evaluate(user_answers)
    return Reporter.new(self, user_answers)
  end

  def generate_problems(number_of_problems, number_of_operands, operand_min, operand_max, operators)
    rng = Random.new
    number_of_problems.times {
      expression = rng.rand(operand_min..operand_max).to_s
      (number_of_operands-1).times {
        current_operand = rng.rand(operand_min..operand_max).to_s
        current_operator = possible_operators.sample
        expression += " " + current_operator + " " + current_operand
      }

      evaluated = eval expression
      self.problems << Problem.new({question: expression, answer: evaluated})
    }
  end
end
