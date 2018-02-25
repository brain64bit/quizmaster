require 'rails_helper'

RSpec.feature "Admin::CreateQuestions", type: :feature do
  scenario "As an user i can create a question" do
    visit admin_questions_path

    click_link "Add Question"
    expect(current_path).to eq new_admin_question_path

    question = "stub-content"
    answer = "stub-answer"

    fill_in_ckeditor "question_content", with: question
    fill_in "Answer", with: answer

    click_button "Save"

    Timeout.timeout(Capybara.default_max_wait_time) do
      current_path == admin_questions_path
    end

    expect(page).to have_content question
    expect(page).to have_content answer
  end
end
