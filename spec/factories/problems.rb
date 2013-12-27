# spec/factories/problems.rb

FactoryGirl.define do
  factory :problem do |f|
    rng = Random.new
    a = rng.rand(1..20)
    b = rng.rand(1..20)
    f.question {a.to_s + " + " + b.to_s}
    f.answer {(a+b).to_s}
  end

  factory :invalid_problem, parent: :problem do |f|
    f.answer nil
  end
end
