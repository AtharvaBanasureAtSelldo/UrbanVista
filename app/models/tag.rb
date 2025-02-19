class Tag < ApplicationRecord
  belongs_to :tenant
  validates :name, presence: true, uniqueness: true

  has_many :property_tags
  has_many :properties, through: :property_tags

  after_create :create_tenant

  private
  def create_tenant
    puts "A new Tag is created"
  end
end
