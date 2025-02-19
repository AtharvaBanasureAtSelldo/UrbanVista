class User < ApplicationRecord
  belongs_to :tenant

  has_secure_password

  ROLES = %w[admin agent]

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :phone, presence: true, numericality: true, length: { is: 10 }
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }


  # callbacks
  before_create :set_default_role

  private

  def set_default_role
    self.role ||= "agent"
  end
end
