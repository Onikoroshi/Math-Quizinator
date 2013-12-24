class ExamsController < ApplicationController
  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new(params[:exam].permit(:title, problem_ids: []))

    if @exam.save
      redirect_to @exam
    else
      render 'new'
    end
  end

  def show
    @exam = current_exam(params)
  end

  def index
    @exams = Exam.all
  end

  def edit
    @exam = current_exam(params)
  end

  def update
    @exam = current_exam(params)

    if @exam.update_attributes(params[:exam].permit(:title, problem_ids: []))
      redirect_to @exam
    else
      render 'edit'
    end
  end

  def destroy
    @exam = current_exam(params)
    @exam.destroy

    redirect_to exams_path
  end

  # As a Student, take an existing exam
  def take
    @exam = current_exam(params)
  end

  # As a Student, see what score you got on the exam you just took
  def result
    @exam = current_exam(params)

    @exam_reporter = @exam.evaluate(params[:answers])
  end

  private
  def current_exam(parameters)
    return Exam.find(parameters[:id])
  end
end
