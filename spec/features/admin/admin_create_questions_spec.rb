require 'rails_helper'

RSpec.feature "Admin::CreateQuestions", type: :feature do
  scenario "As an user i can create a question" do
    visit admin_questions_path

    click_link "Add Question"
    expect(current_path).to eq new_admin_question_path

    question = "stub-content"
    answer = "stub-answer"

    fill_in "Question", with: question
    fill_in "Answer", with: answer

    click_button "Save"

    expect(current_path).to eq admin_questions_path

    expect(page).to have_content question
    expect(page).to have_content answer
  end
end
