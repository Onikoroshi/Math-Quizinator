require 'test_helper'

class ProblemTest < ActiveSupport::TestCase
  test "should not save problem without a question" do
    prob = Problem.new
    prob.answer = "something"
    assert !prob.save, "saved the problem without a question"
  end

  test "should not save problem without an answer" do
    prob = Problem.new
    prob.question = "something"
    assert !prob.save, "saved the problem without an answer"
  end
end
