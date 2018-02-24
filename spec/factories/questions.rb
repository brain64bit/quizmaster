FactoryBot.define do
  factory :question do
    content { FFaker::Lorem.paragraph + "?" }
    answer { FFaker::Lorem.word }
  end
end
