class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :transactions, dependent: :destroy
  delegate :incomes, :expenses, to: :transactions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
