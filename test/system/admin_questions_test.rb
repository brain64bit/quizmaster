require "application_system_test_case"

class AdminQuestionsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit admin_questions_path

    assert_selector "h1", text: "Manage Questions"
  end
end
