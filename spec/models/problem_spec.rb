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
end