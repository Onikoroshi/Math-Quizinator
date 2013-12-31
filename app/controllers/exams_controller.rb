class ExamsController < ApplicationController
  
  before_filter :authorize_teacher!, :except => [:index, :show, :take, :result]
  before_filter :current_exam, :only => [:show, :edit, :update, :destroy, :take, :result]

  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new(params[:exam].permit(:title, problem_ids: []))

    if @exam.save
      @exam.generate_problems(params[:exam][:number_of_problems].to_i, params[:exam][:number_of_operands].to_i, params[:exam][:operand_min].to_i, params[:exam][:operand_max].to_i, params[:exam][:chosen_operators])
      @exam.save
      redirect_to @exam
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @exams = Exam.all
  end

  def edit
  end

  def update
    if @exam.update_attributes(params[:exam].permit(:title, problem_ids: []))
      @exam.generate_problems(params[:exam][:number_of_problems].to_i, params[:exam][:number_of_operands].to_i, params[:exam][:operand_min].to_i, params[:exam][:operand_max].to_i, params[:exam][:chosen_operators])
      @exam.save
      redirect_to @exam
    else
      render 'edit'
    end
  end

  def destroy
    @exam.destroy

    redirect_to exams_path
  end

  # As a Student, take an existing exam
  def take
  end

  # As a Student, see what score you got on the exam you just took
  def result
    @exam_reporter = @exam.evaluate(params[:answers])
  end

  def teacher_logged_in?
    if user_signed_in? && current_user.is_teacher
      true
    else
      false
    end
  end

  private
  def current_exam
    @exam = Exam.find(params[:id])
  end
end
