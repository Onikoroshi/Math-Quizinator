class ProblemsController < ApplicationController
	# Interact with the "new" view (new.html.erb)
	def new
		@problem = Problem.new # give the view something to work with
	end

	# Add a new problem object to the database
	def create
		# build the object from the parameters given
		@problem = Problem.new(params[:problem].permit(:question, :answer))
		
		if @problem.save # if the save save succeeded,
			redirect_to @problem # take a look at the problem you just created
		else
			render 'new' # otherwise, render the new view with any errors
		end
	end

	# get and show a single math problem
	def show
		@problem = Problem.find(params[:id]) # give the view (show.html.erb) an object to work with
	end

	# show all the math problems in the database
	def index
		@problems = Problem.all # give the view (index.html.erb) objects to work with
	end

	# edit an existing math problem
	def edit
		@problem = Problem.find(params[:id]) # give the view (edit.html.erb) an object to work with
	end

	# update an existing math problem using the parameters given by the edit view
	def update
		@problem = Problem.find(params[:id]) # get a problem object to work with

		# if the update succeeds
		if @problem.update(params[:problem].permit(:question, :answer))
			redirect_to @problem # look at the newly changed problem
		else
			render 'edit' # Otherwise, render the edit view again with any errors
		end
	end

	# delete an existing math problem
	def destroy
		@problem = Problem.find(params[:id]) # get the correct problem object
		@problem.destroy # remove it from the database

		redirect_to problems_path # go back to the list of problems
	end
end
