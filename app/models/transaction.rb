class Transaction < ApplicationRecord
  belongs_to :account

  validates :transaction_type, :details, :amount, :balance, presence: true
  validates :amount, :balance, numericality: { greater_than: 0 }

end
