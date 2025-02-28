class User < ApplicationRecord
  has_many :properties, dependent: :destroy
  has_many :appointments, dependent: :destroy

  has_many :appointments_as_agent, class_name: "Appointment", foreign_key: "user_id"
  has_many :appointments_as_customer, class_name: "Appointment", foreign_key: "customer_id"
  has_many :appointments_as_tenant, class_name: "Appointment", foreign_key: "tenant_id"

  belongs_to :tenant

  has_secure_password

  ROLES = %w[admin agent]

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :phone, presence: true, numericality: true, length: { is: 10 }
  validates :name, presence: true
  validates :password, length: { minimum: 6, maximum: 20 }


  # callbacks
  before_create :set_default_role


  def is_admin?
    role == "admin"
  end

  def is_agent?
    role == "agent"
  end

  private
  def set_default_role
    self.role ||= "agent"
  end
end
