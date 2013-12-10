class ProblemsController < ApplicationController
	def new
	end

	def create
		@problem = Problem.new(problem_params)
		@problem.save
		redirect_to @problem
	end

	# get and show a single math problem
	def show
		@problem = Problem.find(params[:id])
	end

	# show all the math problems in the database
	def index
		@problems = Problem.all
	end

	private
	def problem_params
		params.require(:problem).permit(:question, :answer)
	end
end
