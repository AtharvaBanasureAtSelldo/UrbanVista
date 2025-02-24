class Customer < ApplicationRecord
  validates :name, presence: true
  validates :phoneno, presence: true, length: { is: 10 }
  has_many :appointments, dependent: :destroy

  belongs_to :tenant
end
