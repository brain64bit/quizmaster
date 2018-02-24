class Admin::QuestionsController < ApplicationController
  before_action only: [:edit, :update, :destroy] do
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def edit

  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admin_questions_path, notice: "Question was successfully created"
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to admin_questions_path, notice: "Question was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_questions_path, notice: "Question was successfully removed"
  end

  private
  def question_params
    params.require(:question).permit(:answer, :content)
  end
end
