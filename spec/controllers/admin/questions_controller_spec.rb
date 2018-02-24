require 'rails_helper'

RSpec.describe Admin::QuestionsController, type: :controller do

  describe "GET #index" do
    it "returns questions" do
      question = create :question

      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:questions)).to be_present
      expect(assigns(:questions)).to be_include(question)
    end
  end

  describe "GET #new" do
    it "initialize Question object" do
      get :new
      expect(assigns(:question)).to be_new_record
    end
  end

  describe "POST #create" do
    it "create a question when params valid" do
      post :create, params: { question: { content: "How much the number of Ultraman?", answer: "42" } }

      expect(assigns(:question)).to be_persisted
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to match /question was successfully created/i
    end

    it "failed to create a question when params not valid" do
      post :create, params: { question: { content: "How much the number of Ultraman?", answer: nil } }

      expect(assigns(:question)).not_to be_persisted
      expect(response).to render_template(:new)
    end
  end

  describe "PUT #update" do
    it "update existing question when params valid" do
      question = Question.create(content: "How many the number of Ultraman?", answer: "42")

      put :update, params: { id: question.id, question: { content: "How many the number of Power Ranger?", answer: "5" } }

      updated_question = assigns(:question).reload

      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to match /question was successfully updated/i
      expect(updated_question.answer).to eq "5"
      expect(updated_question.content).to match /power ranger/i
    end

    it "failed to update existing question when params not valid" do
      question = Question.create(content: "How many the number of Ultraman?", answer: "42")

      put :update, params: { id: question.id, question: { content: "How many the number of Power Ranger?", answer: nil } }

      updated_question = assigns(:question).reload

      expect(response).to render_template :edit
      expect(updated_question.answer).to eq "42"
      expect(updated_question.content).to match /ultraman/i
    end
  end

  describe "DELETE #destroy" do
    it "remove question by id" do
      question = Question.create(content: "How many the number of Ultraman?", answer: "42")

      expect(question).to be_persisted
      delete :destroy, params: { id: question.id }
      expect{ question.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
