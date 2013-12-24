class Problem < ActiveRecord::Base
  has_and_belongs_to_many :exams
  
  validates :question, presence: true
  validates :answer, presence: true

  def score(user_answer)
    user_answer == answer ? 1 : 0
  end

  def worth
    return 1
  end
end
