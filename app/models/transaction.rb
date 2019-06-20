class Transaction < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :amount, presence: true
  validates :trans_date, presence: true

  scope :incomes, -> { where(type: 'Income') }
  scope :expenses, -> { where(type: 'Expense') }

  #total, highest, lowest
end
