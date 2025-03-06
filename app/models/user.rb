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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.now
    update_columns(password_reset_token: self.password_reset_token, password_reset_sent_at: self.password_reset_sent_at)
    UserMailer.forgot_password(self).deliver# This sends an e-mail with a link for the user to reset the password
  end

  # This generates a random password reset token for the user
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


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
