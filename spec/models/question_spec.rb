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

require 'rails_helper'

RSpec.describe Question, type: :model do
  context "validation" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:answer) }
  end

  context "callbacks" do
    context ".before_save" do
      it "populate sanitized_answer field with sanitized answer" do
        question = create :question, answer: "  AnsWER 99   "
        expect(question.sanitized_answer).to eq "answer ninety nine"
      end
    end
  end

  describe "#valid_answer?" do
    context "question's answer is one digit or one word" do
      correct_answers = ["5", 5, "five", "Five", "FIVE", "fIVe", "  five  ", "five ", " five"]
      wrong_answers = ["6", 6, "six", "fi ve", " fi ve ", "f!ve", nil, ""]

      context "when question answer is '5'" do
        let(:question) { create :question, answer: '5' }

        correct_answers.each do |answer|
          it "returns true when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq true
          end
        end

        wrong_answers.each do |answer|
          it "returns false when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq false
          end
        end
      end

      context "when question answer is 'five'" do
        let(:question) { create :question, answer: 'five' }

        correct_answers.each do |answer|
          it "returns true when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq true
          end
        end

        wrong_answers.each do |answer|
          it "returns false when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq false
          end
        end
      end
    end

    context "question's answer is more than one digit or one word" do
      correct_answers = [
        "1988",
        "one thousand nine hundred eighty eight",
        "one thousand nine hundred 88",
        " 1988 ",
        " one thousand nine hundred eighty eight ",
        " ONE THOUSAND NINE HUNDRED EIGHTY EIGHT "

      ]
      wrong_answers = [
        "1998",
        " nineteen eighty eight ",
        "19 88",
        "19-88",
        "",
        nil
      ]
      context "when question answer is '1988'" do
        let(:question) { create :question, answer: '1988' }

        correct_answers.each do |answer|
          it "returns true when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq true
          end
        end

        wrong_answers.each do |answer|
          it "returns false when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq false
          end
        end
      end

      context "when question answer is 'one thousand nine hundred eighty eight'" do
        let(:question) { create :question, answer: 'one thousand nine hundred eighty eight' }

        correct_answers.each do |answer|
          it "returns true when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq true
          end
        end

        wrong_answers.each do |answer|
          it "returns false when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq false
          end
        end
      end
    end

    context "question answer is combination words and digits" do
      correct_answers = [
        " dillan 1990 ",
        "DILLan 1990  ",
        "dillan one thousand nine hundred ninety",
        "DILLAN ONE THOUSAND NINE HUNDRED NINETY"
      ]
      wrong_answers = [
        "dillan 199",
        "dillan nineteen ninety",
      ]

      context "when question answer is 'Dillan 1990'" do
        let(:question) { create :question, answer: 'Dillan 1990' }

        correct_answers.each do |answer|
          it "returns true when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq true
          end
        end

        wrong_answers.each do |answer|
          it "returns false when given answer is #{answer}" do
            expect(question.valid_answer?(answer)).to eq false
          end
        end
      end
    end
  end

  describe "#sanitize" do
    let(:question) { build :question }
    let(:given_answers) do
      [
        [" Joni 6969 BC", "joni six thousand nine hundred sixty nine bc"],
        ["12 Monkeys", "twelve monkeys"],
        [" FIve foo 5", "five foo five"]
      ]
    end

    it "perform strip, downcase and convert any digit to english words" do
      given_answers.each do |dirty, clean|
        expect(question.sanitize(dirty)).to eq clean
      end
    end
  end
end
