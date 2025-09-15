class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :cart, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def current_cart
    cart || create_cart(session_id: SecureRandom.hex)
  end
end
