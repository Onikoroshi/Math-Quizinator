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

	# get and show a single math problem
	def show
		@problem = Problem.find(params[:id])
	end

	# show all the math problems in the database
	def index
		@problems = Problem.all
	end

	# edit an existing math problem
	def edit
		@problem = Problem.find(params[:id])
	end

	# update an existing math problem
	def update
		@problem = Problem.find(params[:id])

		if @problem.update(params[:problem].permit(:question, :answer))
			redirect_to @problem
		else
			render 'edit'
		end
	end

	# deleting an existing math problem
	def destroy
		@problem = Problem.find(params[:id])
		@problem.destroy

		redirect_to problems_path
	end

	private
	def problem_params
		params.require(:problem).permit(:question, :answer)
	end
end
