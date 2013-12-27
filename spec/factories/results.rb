# spec/factories/results.rb

FactoryGirl.define do
  factory :result do |f|
    prob = FactoryGirl.create(:problem)
    f.problem prob

    answer = Random.rand(0..1) ? prob.answer : "wrong answer"
    f.given_answer answer
  end
end