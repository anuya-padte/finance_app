class Category < ApplicationRecord
  belongs_to :user, optional: true
  has_many :transactions, dependent: :nullify
  validates :cat_type, presence: true
end
