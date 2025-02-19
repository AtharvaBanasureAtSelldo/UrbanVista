class Tenant < ApplicationRecord
  validates :name, presence: true
  has_many :users, dependent: :destroy

  after_create :log_new_tenant

  private
  def log_new_tenant
    puts "A new user was registered"
  end
end
