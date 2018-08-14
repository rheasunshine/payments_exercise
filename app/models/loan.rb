class Loan < ActiveRecord::Base
  has_many :payments

  validates :funded_amount, presence: true

  def balance
    funded_amount - payments.sum(&:amount)
  end

  def as_json(options={})
    super(methods: [:balance])
  end
end
