class Role < ApplicationRecord
  has_many :users

  validates :name, :key, presence: true
  validates :name, :key, uniqueness: true
end
