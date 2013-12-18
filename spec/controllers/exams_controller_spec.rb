require 'spec_helper'

describe ExamsController do
  describe "GET #index" do

    it "populates an array of exams" do
      exam = FactoryGirl.create(:exam)
      get :index
      assigns(:exams).should eq([exam])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do

    it "assigns the requested exam to @exam" do
      exam = FactoryGirl.create(:exam)
      get :show, id: exam
      assigns(:exam).should eq(exam)
    end

    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:exam)
      response.should render_template :show
    end
  end

  describe "GET #new" do

    it "assigns a new exam to @exam" do
      get :new
      assigns(:exam).should be_a_new(Exam)
    end

    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      
      it "saves the new exam in the database" do
        expect {
          post :create, exam: FactoryGirl.attributes_for(:exam)
        }.to change(Exam, :count).by(1)
      end

      it "redirects to the :show page" do
        post :create, exam: FactoryGirl.attributes_for(:exam)
        response.should redirect_to Exam.last
      end
    end

    context "with invalid attributes" do
      
      it "does not save the new exam in the database" do
        expect {
          post :create, exam: FactoryGirl.attributes_for(:invalid_exam)
        }.to_not change(Exam, :count)
      end

      it "re-renders the :new template" do
        post :create, exam: FactoryGirl.attributes_for(:invalid_exam)
        response.should render_template :new
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @exam = FactoryGirl.create(:exam, title: "an Exam")
    end

    context "with valid attributes" do
      
      it "located the requested @exam" do
        put :update, id: @exam, exam: FactoryGirl.attributes_for(:exam)
        assigns(:exam).should eq(@exam)
      end

      it "changes @exam's attributes" do
        put :update, id: @exam, exam: FactoryGirl.attributes_for(:exam, title: "A different Exam")
        @exam.reload
        @exam.title.should eq("A different Exam")
      end

      it "redirects to the updated exam page" do
        put :update, id: @exam, exam: FactoryGirl.attributes_for(:exam)
        response.should redirect_to @exam
      end
    end

    context "with invalid attributes" do
      
      it "locates the requested @exam" do
        put :update, id: @exam, exam: FactoryGirl.attributes_for(:invalid_exam)
        assigns(:exam).should eq(@exam)
      end

      it "does not change @exam's attributes" do
        put :update, id: @exam, exam: FactoryGirl.attributes_for(:exam, title: nil)
        @exam.reload
        @exam.title.should eq("an Exam")
      end
      
      it "re-renders the :edit view" do
        put :update, id: @exam, exam: FactoryGirl.attributes_for(:invalid_exam)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @exam = FactoryGirl.create(:exam)
    end

    it "remove the exam from the database" do
      expect {
        delete :destroy, id: @exam
      }.to change(Exam, :count).by(-1)
    end

    it "redirects to exams#index" do
      delete :destroy, id: @exam
      response.should redirect_to exams_path
    end
  end
end
