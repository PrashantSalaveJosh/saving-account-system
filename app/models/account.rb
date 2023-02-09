class Account < ApplicationRecord
  belongs_to :user
  belongs_to :branch
  has_many :transactions

  before_create :set_account_no

  validates :account_type, :total_balance, presence: true
  validates :total_balance, numericality: { greater_than: 0 }
  validates :account_no, uniqueness: true
  validates :user_id, uniqueness: true

  def set_account_no
    if Account.count.eql?(0)
      self.account_no = 131310001
    else
      max_account_no = Account.maximum(:account_no)
      self.account_no = max_account_no + 1
    end
  end

end
