require 'rails_helper'

RSpec.feature "Admin::UpdateQuestions", type: :feature do
  let!(:existing_question) { create :question, content: "stub-old-content" }

  scenario "As an user i can update a existing question" do
    visit admin_questions_path

    click_link "Edit"
    expect(current_path).to eq edit_admin_question_path(existing_question)

    question = "stub-new-content"
    answer = "stub-new-answer"

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
