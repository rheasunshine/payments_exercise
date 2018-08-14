require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :create, params: { loan_id: loan.id, amount: 10 }
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment attributes are invalid' do
      it 'responds with a 404' do
        get :create, params: { loan_id: loan.id }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :index, params: { loan_id: loan.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment_one) { loan.payments.create!(amount: 10) }

    it 'responds with a 200' do
      get :show, params: { loan_id: loan.id, id: payment_one.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, params: { loan_id: loan.id, id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
