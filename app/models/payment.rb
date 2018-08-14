class Payment < ApplicationRecord
  belongs_to :loan

  validates :loan, presence: true
  validates :amount, presence: true

  validates_numericality_of :amount,
    greater_than: 0,
    message: 'must be greater than 0.'

  validates_numericality_of :amount,
    less_than_or_equal_to: ->(p) {p.loan.balance},
    message: 'must be less than outstanding balance.'

  validate :valid_payment_date

  private

  def valid_payment_date
    self.payment_date ||= Time.now
    errors.add(:payment_date, 'cannot be in the future.') if self.payment_date > Time.now
  end
end
