class Account < ApplicationRecord
  belongs_to :user
  belongs_to :branch
  has_many :transactions

  before_create :set_account_no

  validates :account_no, :account_type, :total_balance, presence: true

  def set_account_no
    if Account.count.eql?(0)
      self.account_no = 1313100001
    else
      max_account_no = Account.maximum(:account_no)
      self.account_no = max_account_no + 1
    end
  end

end
