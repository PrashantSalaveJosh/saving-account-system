class Account < ApplicationRecord
  belongs_to :user
  belongs_to :branch
  has_many :transactions

  validates :account_no, :account_type, :total_balance, presence: true
end
