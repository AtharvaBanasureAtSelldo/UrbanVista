class Appointment < ApplicationRecord
  belongs_to :tenant
  belongs_to :customer
  belongs_to :property
  belongs_to :user

  validates :date, presence: true
  validates :time, presence: true
  validates :customer_id, presence: true
  validates :property_id, presence: true
  validates :user_id, presence: true

  validate :unique_appointment

  private

  def unique_appointment
    existing_appointment = Appointment.where(
      date: date,
      time: time,
      customer_id: customer_id,
      property_id: property_id
    ).first

    if existing_appointment.present? && existing_appointment != self
      errors.add(:base, "An appointment already exists for the given date, time, customer, and property.")
    end
  end
end
