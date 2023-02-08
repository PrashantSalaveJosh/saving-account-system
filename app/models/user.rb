class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  belongs_to :role
  has_one :account

  validates :first_name, :last_name, :contact_no, :address, :dob, :gender, presence: true, on: :update
  validates :contact_no, numericality: { only_integer: true }, length: { is: 10 }, on: :update
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
    message: "only letters allowed" }, on: :update

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super
  end

end
