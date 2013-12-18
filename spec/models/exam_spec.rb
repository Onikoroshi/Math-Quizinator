# spec/models/exam.rb
require 'spec_helper'

describe Exam do
  it "has a valid factory" do
    FactoryGirl.create(:exam).should be_valid
  end
  it "is invalid without a title" do
    FactoryGirl.build(:exam, title: nil).should_not be_valid
  end
  it "should have many problems" do
    t = Exam.reflect_on_association(:problems)
    t.macro.should == :has_and_belongs_to_many
  end
  it "sets problem list with given problem ids" do
    exm = FactoryGirl.create(:exam)
    prob_1 = FactoryGirl.create(:problem)
    prob_2 = FactoryGirl.create(:problem)
    prob_3 = FactoryGirl.create(:problem)
    prob_4 = FactoryGirl.create(:problem)
    probs = [prob_1, prob_2, prob_3, prob_4]

    exm.problem_ids = [prob_1.id, prob_2.id, prob_3.id, prob_4.id]
    exm.problems.should == probs
  end
  it "returns a result array and a score when scored" do
    exm = FactoryGirl.create(:exam)

    prob_1 = FactoryGirl.create(:problem)
    prob_2 = FactoryGirl.create(:problem)
    prob_3 = FactoryGirl.create(:problem)
    prob_4 = FactoryGirl.create(:problem)
    exm.problem_ids = [prob_1.id, prob_2.id, prob_3.id, prob_4.id]

    answers = [prob_1.answer, prob_2.answer+"b", prob_3.answer, prob_4.answer+"b"]
    correct_score = 2
    correct_results = [
        [prob_1.question, prob_1.answer, "", false],
        [prob_2.question, prob_2.answer, answers[1], true],
        [prob_3.question, prob_3.answer, "", false],
        [prob_4.question, prob_4.answer, answers[3], true]
      ]
    score, results = exm.score(answers)
    score.should == correct_score
    results.should == correct_results
  end
end