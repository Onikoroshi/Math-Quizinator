class Problem < ActiveRecord::Base
  has_and_belongs_to_many :exams
  
  validates :question, presence: true
  validates :answer, presence: true

  def is_in
    return 1
  end
end
