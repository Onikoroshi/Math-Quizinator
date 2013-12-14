class ExamsController < ApplicationController
	def new
		@exam = Exam.new
	end

	def create
		@exam = Exam.new(params[:exam].permit(:title, :problem_ids))

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

	# edit an existing quiz
	def edit
		@exam = Exam.find(params[:id])
	end

	# update an existing quiz
	def update
		@exam = Exam.find(params[:id])
		# @exam.problems = Problem.all

		@exam.problems = []
		params[:exam][:problem_ids].each {
			|prob_id|
			@exam.problems << Problem.find(prob_id)
		}
		
		if @exam.update_attributes(params[:exam].permit(:title, problems_attributes: [:id, :question, :answer]))
			redirect_to @exam
		else
			render 'edit'
		end
	end

	def take
		@exam = Exam.find(params[:id])
	end

	def result
		@exam = Exam.find(params[:id])
		@results = []
		@score = 0
		params[:answers].each_with_index {
			|ans, index|
			prob = @exam.problems[index]
			if ans == prob.answer
				@score += 1
				@results << [prob.question, prob.answer, false]
			else
				@results << [prob.question, "You said: " + ans.to_s + "; should be: " + prob.answer.to_s, true]
			end
		}
	end

	def destroy
		@exam = Exam.find(params[:id])
		@exam.destroy

		redirect_to exams_path
	end
end
