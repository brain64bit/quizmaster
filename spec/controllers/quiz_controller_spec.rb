require 'rails_helper'

RSpec.describe QuizController, type: :controller do
  let!(:questions) { create_list :question, 3 }

  describe "GET #index" do
    context "when query params[:reset] exist" do
      before do
        request.session[:question_ids] = "stub-session"
      end

      it "reset session question_ids to list of unanswered question_ids" do
        expect(request.session[:question_ids]).to eq "stub-session"

        get :index, params: { reset: true }

        expect(request.session[:question_ids].keys).to  match_array(questions.pluck(:id))
        expect(request.session[:question_ids].values.compact).to be_empty
      end
    end

    context "when session question_ids not exist" do
      before do
        request.session[:question_ids] = nil
        get :index
      end

      it "return first randomly choosen of unanswered question w/o answer" do
        expect(response).to have_http_status(:success)
        expect(questions).to be_include(assigns[:question])
        expect{ assigns[:question].answer }.to raise_error(ActiveModel::MissingAttributeError)
      end

      it "generate session question_ids with unanswered question ids" do
        expect(response).to have_http_status(:success)

        question_ids = request.session[:question_ids]
        expect(question_ids.keys).to match_array questions.map(&:id)
        expect(question_ids.values.compact).to be_empty
      end
    end

    context "when session question_ids is exist" do
      before do
        prepared_question_ids = Hash[*questions.map{|q| [q.id, true] }.flatten]
        unanswered_question_id = prepared_question_ids.keys.sample
        prepared_question_ids[unanswered_question_id] = nil

        request.session[:question_ids] = prepared_question_ids
        get :index
      end

      it "return first randomly choosen of unanswered question w/o answer" do
        unanswered_question_ids = request.session[:question_ids].select{|k,v| v.nil? }.keys

        expect(response).to have_http_status(:success)
        expect(assigns[:question].id).to eq unanswered_question_ids.first
        expect{ assigns[:question].answer }.to raise_error(ActiveModel::MissingAttributeError)
      end
    end
  end

  describe "POST #answer" do
    let(:question){ create :question, answer: 'stub-answer' }

    it "response ok with answer status true & mark question true, when given answer is correct" do
      allow(controller).to receive(:mark_question)
      post :answer, params: { id: question.id, answer: "stub-answer", format: "json" }

      expect(response).to have_http_status(:ok)
      expect(controller).to have_received(:mark_question).with(question.id, true)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["answer_status"]).to eq "true"
    end

    it "response ok with answer status false & mark question false, when given answer is wrong" do
      allow(controller).to receive(:mark_question)
      post :answer, params: { id: question.id, answer: "not-stub-answer", format: "json" }

      expect(response).to have_http_status(:ok)
      expect(controller).to have_received(:mark_question).with(question.id, false)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["answer_status"]).to eq "false"
    end
  end

  describe "GET #next_question" do
    context "when unanswered question ids exist in session" do
      let(:questions) { create_list :question, 3 }

      before do
        unanswered_question_ids = Hash[*questions.map { |q| [q.id, nil] }.flatten]
        request.session[:question_ids] = unanswered_question_ids
        get :next_question, params: { format: "json" }
      end
      it "response ok and return only question id and content based on random unanswered question ids" do
        expect(response).to have_http_status(:ok)

        parsed_response = JSON.parse(response.body)
        expect(questions.map(&:id)).to be_include(parsed_response["id"])
        expect(parsed_response["content"]).to be_present
        expect(parsed_response.has_key?("answer")).to eq false
      end
    end

    context "when unanswered question ids already answered" do
      let(:questions) { create_list :question, 3 }

      before do
        answered_question_ids = Hash[*questions.map { |q| [q.id, true] }.flatten]
        request.session[:question_ids] = answered_question_ids
        get :next_question, params: { format: "json" }
      end

      it "response not found" do
        expect(response).to have_http_status(:not_found)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_blank
      end
    end

    context "when session question ids not found" do
      before do
        get :next_question, params: { format: "json" }
      end

      it "response not found" do
        expect(response).to have_http_status(:not_found)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_blank
      end
    end
  end

  describe "GET #finish" do
    before do
      request.session[:question_ids] = {
        1 => true,
        2 => false,
        3 => true,
        4 => false,
        5 => true
      }
      get :finish
    end

    it "calculate score from answered questions" do
      expect(assigns[:score]).to eq 60.0
    end
  end

  describe "#mark_question" do
    let(:question_ids) do
      {
        1 => nil,
        2 => nil,
        3 => nil
      }
    end

    before do
      request.session[:question_ids] = question_ids
    end

    it "marks answered question with answer state" do
      controller.mark_question(1, false)
      controller.mark_question(2, true)

      updated_question_ids = request.session[:question_ids]

      expect(updated_question_ids[1]).to eq false
      expect(updated_question_ids[2]).to eq true
      expect(updated_question_ids[3]).to eq nil
    end
  end
end
