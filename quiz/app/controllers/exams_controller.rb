class ExamsController < ApplicationController
	def new
		@exam = Exam.new
	end

	def create
		@exam = Exam.new(params[:exam].permit(:title))
		
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

	# edit an existing quiz
	def edit
		@exam = Exam.find(params[:id])
	end

	# update an existing quiz
	def update
		@exam = Exam.find(params[:id])
		
		if @exam.update_attributes(params[:exam].permit(:title, :problem_ids))
			redirect_to @exam
		else
			render 'edit'
		end
	end
end
