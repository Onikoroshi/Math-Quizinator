class ProblemsController < ApplicationController
  def new
    @problem = Problem.new
  end

  def create
    @problem = Problem.new(params[:problem].permit(:question, :answer))
    
    if @problem.save
      redirect_to @problem
    else
      render 'new'
    end
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def index
    @problems = Problem.all
  end

  def edit
    @problem = Problem.find(params[:id])
  end

  def update
    @problem = Problem.find(params[:id])

    if @problem.update(params[:problem].permit(:question, :answer))
      redirect_to @problem
    else
      render 'edit'
    end
  end

  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    redirect_to problems_path
  end
end
