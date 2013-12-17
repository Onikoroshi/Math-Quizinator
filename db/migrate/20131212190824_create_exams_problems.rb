class CreateExamsProblems < ActiveRecord::Migration
  def change
    create_table :exams_problems, :id => false do |t|
    	t.integer :exam_id
    	t.integer :problem_id
    end
  end
end
