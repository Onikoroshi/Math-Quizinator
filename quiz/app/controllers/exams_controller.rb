class ExamsController < ApplicationController
	def new
		@exam = Exam.new
	end

	# called when submitting a new Exam
	def create
		# Create an Exam object using the parameters submitted
		@exam = Exam.new(params[:exam].permit(:title, :problem_ids))

		# I couldn't figure out how to get Rails to automatically update the many-to-many relationship parameters, so I do it manually.
		@exam.problems = []
		params[:exam][:problem_ids].each {
			|prob_id|
			@exam.problems << Problem.find(prob_id)
		}
		
		# if the exam is a proper object and saves successfully
		if @exam.save
			redirect_to @exam # show the exam we've created
		else
			render 'new' # Otherwise, render the new page again with any errors (_form.html.erb)
		end
	end

	# Show a simple view of a single exam.
	def show
		@exam = Exam.find(params[:id]) # the view (show.html.erb) needs an exam object to work with
	end

	# Show all of the exams
	def index
		@exams = Exam.all # the view (index.html.erb) needs a set of exam objects to work with
	end

	# edit an existing exam
	def edit
		@exam = Exam.find(params[:id]) # the view (edit.html.erb) needs an exam object to work with
	end

	# update an existing exam
	def update
		@exam = Exam.find(params[:id]) # we need an exam object to work with

		# I couldn't figure out how to get Rails to automatically update the many-to-many relationship parameters, so I do it manually.
		@exam.problems = []
		params[:exam][:problem_ids].each {
			|prob_id|
			@exam.problems << Problem.find(prob_id)
		}
		
		# update the paramters of the exam object (as far as I can tell, the problem_attributes bit doesn't do anything)
		if @exam.update_attributes(params[:exam].permit(:title, problems_attributes: [:id, :question, :answer]))
			redirect_to @exam # if it worked, show the exam we've successfully updated
		else
			render 'edit' # Otherwise, render the edit page again with any errors
		end
	end

	# As a Student, take an existing exam
	def take
		@exam = Exam.find(params[:id]) # the view (take.html.erb) needs an exam object to work with
	end

	# As a Student, see what score you got on the exam you just took
	def result
		@exam = Exam.find(params[:id]) # the view (result.html.erb) needs an exam object to work with

		@results = [] # the view needs a set of results to display
		@score = 0 # the view needs an overall score to display

		# look at each answer submitted by the user, and save which answer number that was
		params[:answers].each_with_index {
			|ans, index|
			prob = @exam.problems[index] # find the problem that goes with this answer
			if ans == prob.answer # if they got the answer right
				@score += 1 # add one to their score

				# and build something for the view to display.
				# In this case, just the problem string, the answer string, and a boolean indicating that this does not need to be highlighted (because they got it right)
				@results << [prob.question, prob.answer, false]
			else # if they missed this question,
				# build something for the view to display
				# In this case, the problem string, what they entered, what they should have entered, and a boolean indicating that this *does* need to be highlighted (because they got it wrong)
				@results << [prob.question, "You said: " + ans.to_s + "; should be: " + prob.answer.to_s, true]
			end
		}
	end

	# remove an exam from the database
	def destroy
		@exam = Exam.find(params[:id]) # find the exam from the given parameters
		@exam.destroy # remove it from the database

		redirect_to exams_path # go back to the master list of exams
	end
end
