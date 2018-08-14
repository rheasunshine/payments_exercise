require 'rails_helper'

RSpec.describe Payment, :type => :model do
  let(:loan) { Loan.create(funded_amount: 100) }

  describe 'validations' do
    subject { described_class.new(loan: loan, amount: 10) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an amount" do
      subject.amount = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Amount can't be blank")
    end

    it "is not valid with an amount less than 0" do
      subject.amount = 0
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Amount must be greater than 0.")
    end

    it "is not valid with an amount greater than the outstanding balance" do
      subject.amount = 200
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Amount must be less than outstanding balance.")
    end

    context 'has no payment date specified' do
      let(:payment) { Payment.create(loan: loan, amount: 1) }

      it 'is valid with no payment date specified' do
        expect(payment).to be_valid
        expect(payment.payment_date).to be < Time.now
      end
    end

    context 'has a payment date specified' do
      let(:payment) { Payment.create(loan: loan, amount: 1) }

      it 'is valid with a past date' do
        payment.payment_date = 10.days.ago
        expect(payment).to be_valid
      end

      it 'is throws error with a future date' do
        payment.payment_date = 10.days.from_now
        expect(payment).to_not be_valid
        expect(payment.errors.full_messages).to include("Payment date cannot be in the future.")
      end
    end
  end
end
