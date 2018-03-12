class QuizController < ApplicationController
  def index
    if params[:reset]
      session[:question_ids] = nil
    end

    if question_ids.present?
      unanswered_question_ids = question_ids.select{|k,v| v.nil? }
      if unanswered_question_ids.blank?
        redirect_to quiz_finish_path
        return
      end
      @question = Question.where(id: unanswered_question_ids.keys).order("random()").select(:id, :content).first
    else
      questions = Question.order("random()").limit(5).select(:id, :content)
      prepared_question_ids = Hash[*questions.map{|q| [q.id, nil] }.flatten]
      session[:question_ids] = prepared_question_ids
      @question = questions.sample
    end
  end

  def answer
    question = Question.find(params[:id])
    respond_to do |format|
      if question.valid_answer?(params[:answer])
        mark_question question.id, true
        format.json do
          render json: { answer_status: "true" }, status: 200
        end
      else
        mark_question question.id, false
        format.json do
          render json: { answer_status: "false" }, status: 200
        end
      end
    end
  end

  def next_question
    id = question_ids.select{|k,v| v.nil? }.keys.sample
    question = Question.select(:id, :content).find(id)
    respond_to do |format|
      format.json do
        render json: question.to_json, status: 200
      end
    end
  end

  def finish
    correct = question_ids.select{|k,v| v == true}.size.to_f
    @score = ( correct / question_ids.size ) * 100
  end

  def mark_question(question_id, answer_state)
    current_question_ids = question_ids
    current_question_ids[question_id] = answer_state
    session[:question_ids] = current_question_ids
  end

  private
  def question_ids
    session[:question_ids] || {}
  end
end
