class Exam < ActiveRecord::Base
  has_and_belongs_to_many :problems

  validates :title, presence: true

  accepts_nested_attributes_for :problems

  class Result
    def initialize(problem, user_answer)
      @problem = problem
      @given_answer = user_answer
    end

    def worth
      @problem.worth
    end

    def score
      @problem.score(user_answer)
    end

    def question
      @problem.question
    end

    def correct_answer
      @problem.answer
    end

    def user_answer
      @given_answer
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
      @results.inject(0) {
        |score_so_far, current_result|
        score_so_far + current_result.score
      }
    end

    def total_possible
      @results.inject(0) {
        |total_so_far, current_result|
        total_so_far + current_result.worth
      }
    end

    def results
      @results
    end
  end

  def evaluate(user_answers)
    Reporter.new(self, user_answers)
  end

  def possible_operators
    ["+", "-", "*"]
  end

  def generate_problems(number_of_problems, number_of_operands, operand_min, operand_max, given_operators)
    rng = Random.new
    number_of_problems.times {
      expression = rng.rand(operand_min..operand_max).to_s
      (number_of_operands-1).times {
        current_operand = rng.rand(operand_min..operand_max).to_s
        current_operator = given_operators.sample
        expression += " " + current_operator + " " + current_operand
      }

      evaluated = eval expression
      self.problems << Problem.new({question: expression, answer: evaluated})
    }
  end
end
