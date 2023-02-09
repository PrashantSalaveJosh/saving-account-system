class Branch < ApplicationRecord
  has_many :accounts

  validates :name, :contact_no, :address, :ifsc, presence: true
  validates :name, :contact_no, :ifsc, uniqueness: true
  validates :contact_no, numericality: { only_integer: true },length: { is: 10 }
end
