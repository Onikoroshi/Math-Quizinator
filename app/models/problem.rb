class Problem < ActiveRecord::Base
  has_and_belongs_to_many :exams
  
  validates :question, presence: true
  validates :answer, presence: true

  accepts_nested_attributes_for :exams
end
