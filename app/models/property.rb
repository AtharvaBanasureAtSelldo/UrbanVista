class Property < ApplicationRecord
  belongs_to :tenant


  has_many :appointments, dependent: :destroy
  has_many :property_tags
  has_many :tags, through: :property_tags

  validates :title, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :tenant_id, presence: true
  validates :user_id, presence: true
end
