class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category , optional: true

  default_scope -> { order(trans_date: :asc) }

  validates :user_id, presence: true
  validates :amount, presence: true
  validates :category_id, presence: true
  validates :trans_date, presence: true

  scope :incomes, -> { where(type: 'Income') }
  scope :expenses, -> { where(type: 'Expense') }

  def self.types
    %w(Income Expense)
  end
end
