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
    @exam.problem_ids = params[:exam][:problem_ids]
=begin    
    @exam.problems = []
    params[:exam][:problem_ids].each {
      |prob_id|
      @exam.problems << Problem.find(prob_id)
    }
=end
    
    # update the paramters of the exam object (as far as I can tell, the problem_attributes bit doesn't do anything)
    if @exam.update_attributes(params[:exam].permit(:title, :problem_ids))
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

    @score, @results = @exam.score(params[:answers])
  end
end
