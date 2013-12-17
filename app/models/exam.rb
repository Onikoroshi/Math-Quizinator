class Exam < ActiveRecord::Base
  has_and_belongs_to_many :problems

  validates :title, presence: true

  accepts_nested_attributes_for :problems
end
