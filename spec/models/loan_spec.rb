require 'rails_helper'

RSpec.describe Loan, :type => :model do
  describe 'validations' do
    subject { described_class.new(funded_amount: 100) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a funded_amount" do
      subject.funded_amount = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Funded amount can't be blank")
    end
  end

  describe 'outstanding balance' do
    subject { described_class.new(funded_amount: 100) }

    context 'with no payments made' do
      it { expect(subject.payments).to eq([]) }
      it { expect(subject.balance).to eq(subject.funded_amount) }
    end

    context 'with payments made' do
      let(:payment_one) { subject.payments.new(amount: 10) }

      it 'has one payment made' do
        expect(subject.payments).to eq([payment_one])
        expect(subject.balance).to eq(90)
      end

      let(:payment_two) { subject.payments.new(amount: 2) }
      let(:payment_three) { subject.payments.new(amount: 13) }

      it 'has multiple payments made' do
        expect(subject.payments).to eq([payment_one, payment_two, payment_three])
        expect(subject.balance).to eq(75)
      end
    end
  end
end
