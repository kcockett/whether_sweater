class User < ApplicationRecord
  
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  
  has_secure_password

  before_create :generate_api_key

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(26)
      break unless User.exists?(api_key: self.api_key)
    end
  end
end