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

FactoryBot.define do
  factory :question do
    content { FFaker::Lorem.paragraph + "?" }
    answer { FFaker::Lorem.word }
  end
end
