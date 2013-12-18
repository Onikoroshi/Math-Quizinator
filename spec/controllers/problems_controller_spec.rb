# spec/controllers/problems_controller.rb
require 'spec_helper'

describe ProblemsController do
  describe "GET #index" do

    it "populates an array of problems" do
      problem = FactoryGirl.create(:problem)
      get :index
      assigns(:problems).should eq([problem])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do

    it "assigns the requested problem to @problem" do
      problem = FactoryGirl.create(:problem)
      get :show, id: problem
      assigns(:problem).should eq(problem)
    end

    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:problem)
      response.should render_template :show
    end
  end

  describe "GET #new" do

    it "assigns a new Problem to @problem" do
      get :new
      assigns(:problem).should be_a_new(Problem)
    end

    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      
      it "saves the new problem in the database" do
        expect {
          post :create, problem: FactoryGirl.attributes_for(:problem)
        }.to change(Problem, :count).by(1)
      end

      it "redirects to the :show page" do
        post :create, problem: FactoryGirl.attributes_for(:problem)
        response.should redirect_to Problem.last
      end
    end

    context "with invalid attributes" do
      
      it "does not save the new problem in the database" do
        expect {
          post :create, problem: FactoryGirl.attributes_for(:invalid_problem)
        }.to_not change(Problem, :count)
      end

      it "re-renders the :new template" do
        post :create, problem: FactoryGirl.attributes_for(:invalid_problem)
        response.should render_template :new
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @problem = FactoryGirl.create(:problem, question: "5 + 5", answer: "10")
    end

    context "with valid attributes" do
      
      it "located the requested @problem" do
        put :update, id: @problem, problem: FactoryGirl.attributes_for(:problem)
        assigns(:problem).should eq(@problem)
      end

      it "changes @problem's attributes" do
        put :update, id: @problem, problem: FactoryGirl.attributes_for(:problem, question: "1 + 1", answer: "2")
        @problem.reload
        @problem.question.should eq("1 + 1")
        @problem.answer.should eq("2")
      end

      it "redirects to the updated problem page" do
        put :update, id: @problem, problem: FactoryGirl.attributes_for(:problem)
        response.should redirect_to @problem
      end
    end

    context "with invalid attributes" do
      
      it "locates the requested @problem" do
        put :update, id: @problem, problem: FactoryGirl.attributes_for(:invalid_problem)
        assigns(:problem).should eq(@problem)
      end

      it "does not change @problem's attributes" do
        put :update, id: @problem, problem: FactoryGirl.attributes_for(:problem, question: "1 + 1", answer: nil)
        @problem.reload
        @problem.question.should_not eq("1 + 1")
        @problem.answer.should eq("10")
      end
      
      it "re-renders the :edit view" do
        put :update, id: @problem, problem: FactoryGirl.attributes_for(:invalid_problem)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @problem = FactoryGirl.create(:problem)
    end

    it "remove the problem from the database" do
      expect {
        delete :destroy, id: @problem
      }.to change(Problem, :count).by(-1)
    end

    it "redirects to problems#index" do
      delete :destroy, id: @problem
      response.should redirect_to problems_path
    end
  end
end