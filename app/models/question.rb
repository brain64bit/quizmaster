class Question < ApplicationRecord
  validates :content, :answer, presence: true

  def valid_answer?(given_answer)
    self.answer == given_answer.to_s || self.answer.to_i.humanize == given_answer.to_s.downcase
  end
end
