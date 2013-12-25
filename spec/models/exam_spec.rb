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
  it "returns a proper Reporter object when scored" do
    exm = FactoryGirl.create(:exam)

    prob_1 = FactoryGirl.create(:problem)
    prob_2 = FactoryGirl.create(:problem)
    prob_3 = FactoryGirl.create(:problem)
    prob_4 = FactoryGirl.create(:problem)
    exm.problem_ids = [prob_1.id, prob_2.id, prob_3.id, prob_4.id]

    answers = {prob_1.id.to_s => prob_1.answer, prob_2.id.to_s => prob_2.answer+"b", prob_3.id.to_s => prob_3.answer, prob_4.id.to_s => prob_4.answer+"b"}
    correct_score = 2
    correct_total = 4

    results = exm.evaluate(answers)
    results.score.should == correct_score
    results.total_possible.should == correct_total
  end
end