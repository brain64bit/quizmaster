class QuizController < ApplicationController
  def index
    @questions = Question.all.select(:id, :content)
  end

  def answer
    question = Question.find(params[:id])
    respond_to do |format|
      if question.valid_answer?(params[:answer])
        format.json do
          render json: { answer_status: "true", status: 200 }
        end
      else
        format.json do
          render json: { answer_status: "false", status: 200 }
        end
      end
    end
  end
end
