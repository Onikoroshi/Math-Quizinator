require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  test "do not save without a title" do
    exm = Exam.new
    assert !exm.save
  end

  test "has questions" do
    an_exam = exams(:exam_4)
=begin
    an_exam.problems.each {
      |prob|
      puts prob.question + " = " + prob.answer
    }
=end
    assert true
  end

  test "get results" do
    an_exam = exams(:exam_4)
    answers = ["1", "3", "5", "9"]

    score, results = an_exam.score(answers)
    correct_score = 2
    correct_results = [
      ["0 + 0", "0", "1", true],
      ["1 + 2", "3", "", false],
      ["2 + 4", "6", "5", true],
      ["3 + 6", "9", "", false]
    ]

    assert_equal score, correct_score
    assert_equal results, correct_results
  end

=begin
  test "see problem list" do
    Problem.all.each {
      |prob|
      puts prob.id.to_s + " - " + prob.question.to_s + " = " + prob.answer.to_s
    }
    assert true
  end
=end

  test "set problem list" do
    an_exam = exams(:exam_6)
    prob_ids = [problems(:problem_2).id, problems(:problem_4).id, problems(:problem_6).id, problems(:problem_8).id, problems(:problem_9).id]

    an_exam.problem_ids = prob_ids
    probs = [problems(:problem_2), problems(:problem_4), problems(:problem_6), problems(:problem_8), problems(:problem_9)]

    assert_equal an_exam.problems, probs
  end
end
