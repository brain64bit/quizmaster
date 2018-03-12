require 'rails_helper'

RSpec.feature "QuizChallenges", type: :feature do
  let!(:questions) { create_list :question, 2, content: "stub-question", answer: "stub-answer" }

  scenario "As an user answer the questions and got score 50" do
    visit root_path


    fill_in 'answer', with: "stub-answer"
    click_button 'answer'
    expect(page).to have_content "Your answer is correct!"

    click_link "next"

    fill_in 'answer', with: "not-stub-answer"
    click_button 'answer'
    expect(page).to have_content "Your answer is wrong!"

    click_link "next"
    expect(page).to have_content "50.0"
  end
end
