require 'rails_helper'

RSpec.describe Question, type: :model do
  context "validation" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:answer) }
  end

  describe "#valid_answer?" do
    context "when question answer is contains a number" do
      let(:question) { build :question, content: 'stub-content', answer: '5' }

      it "returns true when question answer is equals with given answer" do
        expect(question.valid_answer?("5")).to eq true
        expect(question.valid_answer?(5)).to eq true
      end

      it "returns true when question answer is equals case insensitive with given answer in words" do
        expect(question.valid_answer?("five")).to eq true
        expect(question.valid_answer?("Five")).to eq true
        expect(question.valid_answer?("FIVE")).to eq true
      end

      it "returns false when question answer is not equals with given answer in number or words version" do
        expect(question.valid_answer?("6")).to eq false
        expect(question.valid_answer?("six")).to eq false
        expect(question.valid_answer?(6)).to eq false
      end

      it "returns false when given answer is nil" do
        expect(question.valid_answer?(nil)).to eq false
      end
    end
  end
end
