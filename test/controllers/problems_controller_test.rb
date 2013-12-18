require 'test_helper'

class ProblemsControllerTest < ActionController::TestCase
  test "should create problem" do
    assert_difference('Problem.count') do
      post :create, problem: {question: "some question", answer: "some answer"}
    end

    assert_redirected_to problem_path(assigns(:problem))
  end

  test "should show problem" do
    get :show, {'id' => problems(:problem_5).id}
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:problems)
  end

  test "should update problem" do
    patch :update, problem: {question: "another question", answer: "an answer"}
    assert_redirected_to problem_path(assigns(:problem))
  end
end
