class Customer < ApplicationRecord
  has_many :appointments, dependent: :destroy

  belongs_to :tenant
end
