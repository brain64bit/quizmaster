class AddSanitizedAnswerToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :sanitized_answer, :string
  end
end
