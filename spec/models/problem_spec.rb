# spec/models/problem.rb
require 'spec_helper'

describe Problem do
  it "has a valid factory" do
    FactoryGirl.create(:problem).should be_valid
  end
  it "is invalid without a question" do
    FactoryGirl.build(:problem, question: nil).should_not be_valid
  end
  it "is invalid without a answer" do
    FactoryGirl.build(:problem, answer: nil).should_not be_valid
  end
  it "should belong to many exams" do
    t = Problem.reflect_on_association(:exams)
    t.macro.should == :has_and_belongs_to_many
  end
  it "should return a 1 when given the right answer" do
    p = FactoryGirl.build(:problem)
    correct_answer = p.answer
    score = p.score(correct_answer)
    score.should == 1
  end
  it "should return a 0 when given the wrong answer" do
    p = FactoryGirl.build(:problem)
    wrong_answer = p.answer + "b"
    score = p.score(wrong_answer)
    score.should == 0
  end
  it "should return a 1 when asked what it's worth" do
    p = FactoryGirl.build(:problem)
    points = p.worth
    points.should == 1
  end
end