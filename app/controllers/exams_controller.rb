class ExamsController < ApplicationController
  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new(params[:exam].permit(:title, :problem_ids))

    # I couldn't figure out how to get Rails to automatically update the many-to-many relationship parameters, so I do it manually.
    @exam.problems = []
    params[:exam][:problem_ids].each {
      |prob_id|
      @exam.problems << Problem.find(prob_id)
    }
    
    if @exam.save
      redirect_to @exam
    else
      render 'new'
    end
  end

  def show
    @exam = Exam.find(params[:id])
  end

  def index
    @exams = Exam.all
  end

  def edit
    @exam = Exam.find(params[:id])
  end

  def update
    @exam = Exam.find(params[:id])

    # I couldn't figure out how to get Rails to automatically update the many-to-many relationship parameters, so I do it manually.
    @exam.problems = []
    params[:exam][:problem_ids].each {
      |prob_id|
      @exam.problems << Problem.find(prob_id)
    }
    
    # update the paramters of the exam object (as far as I can tell, the problem_attributes bit doesn't do anything)
    if @exam.update_attributes(params[:exam].permit(:title, problems_attributes: [:id, :question, :answer]))
      redirect_to @exam
    else
      render 'edit'
    end
  end

  def destroy
    @exam = Exam.find(params[:id]) # find the exam from the given parameters
    @exam.destroy # remove it from the database

    redirect_to exams_path # go back to the master list of exams
  end

  # As a Student, take an existing exam
  def take
    @exam = Exam.find(params[:id])
  end

  # As a Student, see what score you got on the exam you just took
  def result
    @exam = Exam.find(params[:id])

    @results = [] # the view needs a set of results to display
    @score = 0 # the view needs an overall score to display

    # look at each answer submitted by the user, and save which answer number that was
    params[:answers].each_with_index {
      |ans, index|
      prob = @exam.problems[index] # find the problem that goes with this answer
      if ans == prob.answer
        @score += 1
        @results << [prob.question, prob.answer, false]
      else
        @results << [prob.question, "You said: " + ans.to_s + "; should be: " + prob.answer.to_s, true]
      end
    }
  end
end
