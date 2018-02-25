require 'rails_helper'

RSpec.describe QuizController, type: :controller do
  let!(:questions) { create_list :question, 3 }

  describe "GET #index" do
    it "returns questions w/o answer" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:questions)).to match_array questions
      expect{ assigns[:questions].first.answer }.to raise_error(ActiveModel::MissingAttributeError)
    end
  end

  describe "POST #answer" do
    let(:question){ create :question, answer: 'stub-answer' }

    it "response ok with answer status true, when given answer is correct" do
      post :answer, params: { id: question.id, answer: "stub-answer", format: "json" }

      expect(response).to have_http_status(:ok)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["answer_status"]).to eq "true"
    end

    it "response ok with answer status false, when given answer is wrong" do
      post :answer, params: { id: question.id, answer: "not-stub-answer", format: "json" }

      expect(response).to have_http_status(:ok)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["answer_status"]).to eq "false"
    end
  end
end
