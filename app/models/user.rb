class User < ApplicationRecord
  has_secure_password validations: true

  validates :username, presence: true, uniqueness: true

  has_many :payment_orders, class_name: 'Order', foreign_key: :payment_user_id
  has_many :receiving_orders, class_name: 'Order', foreign_key: :receiving_user_id

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end

  def orders
    Order.where(receiving_user_id: id).or(Order.where(payment_user_id: id))
  end

  def total_amount
    receiving_total_amount = receiving_orders.sum(:amount)
    pay_total_amount       = payment_orders.sum(:amount)
    receiving_total_amount - pay_total_amount
  end
end
