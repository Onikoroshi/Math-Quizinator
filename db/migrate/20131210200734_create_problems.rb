class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
