# spec/factories/reporters.rb

FactoryGirl.define do
  factory :reporter do |f|
    prob_1 = FactoryGirl.create(:problem)
    prob_2 = FactoryGirl.create(:problem)
    prob_3 = FactoryGirl.create(:problem)
    prob_4 = FactoryGirl.create(:problem)
    an_exam = FactoryGirl.create(:exam)
    an_exam.problem_ids = [prob_1.id, prob_2.id, prob_3.id, prob_4.id]
    f.exam an_exam
    #f.results [result_1 = FactoryGirl.create(:result), result_2 = FactoryGirl.create(:result), result_3 = FactoryGirl.create(:result), result_4 = FactoryGirl.create(:result)]
  end
end