# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  content          :string
#  answer           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  sanitized_answer :string
#

class Question < ApplicationRecord
  validates :content, :answer, presence: true

  before_save do
    self.sanitized_answer = sanitize(self.answer)
  end

  def valid_answer?(given_answer)
    given_answer = sanitize(given_answer)
    given_answer == self.sanitized_answer
  end

  def sanitize(answer)
    answer = answer.to_s.gsub(/\d+/) do |match|
      match.to_i.to_words.gsub("-", " ")
    end
    answer.strip.downcase
  end
end
