require 'rails_helper'

RSpec.feature "QuizChallenges", type: :feature do
  let!(:question) { create :question, content: "stub-question", answer: "stub-answer" }

  scenario "As an user answer the question correctly" do
    visit root_path

    expect(page).to have_content question.content

    fill_in 'answer', with: "stub-answer"
    click_button 'answer'

    expect(page).to have_content "Your answer is correct!"
  end

  scenario "As an user answer the question wrongly" do
    visit root_path

    expect(page).to have_content question.content

    fill_in 'answer', with: "not-stub-answer"
    click_button 'answer'

    expect(page).to have_content "Your answer is wrong!"
  end
end
