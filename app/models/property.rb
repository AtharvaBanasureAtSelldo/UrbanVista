class Property < ApplicationRecord
  belongs_to :tenant

  has_many :property_tags
  has_many :tags, through: :property_tags
end
