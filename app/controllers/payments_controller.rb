class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: exception, status: :unprocessable_entity
  end

  def create
    @new_payment = Payment.create!(
      loan_id: params[:loan_id],
      amount: params[:amount],
      payment_date: params[:payment_date]
    )
    render json: @new_payment
  end

  def index
    render json: Loan.find(params[:loan_id]).payments
  end

  def show
    render json: Payment.find(params[:id])
  end

  private

  def payment_params
    params.permit(:loan_id, :amount, :payment_date)
  end
end
