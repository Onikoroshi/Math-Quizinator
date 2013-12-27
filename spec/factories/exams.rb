# spec/factories/exams.rb
require 'faker'

FactoryGirl.define do
  factory :exam do |f|
    f.title { Faker::Lorem.words.join(" ") }
  end

  factory :invalid_exam, parent: :exam do |f|
    f.title nil
  end
end