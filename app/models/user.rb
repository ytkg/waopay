class User < ApplicationRecord
  has_secure_password validations: true

  validates :name, presence: true, length: { minimum: 2 }
  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }, format: { with: /\A[a-z0-9]+\z/i }

  has_many :payment_orders, class_name: 'Order', foreign_key: :payment_user_id
  has_many :receiving_orders, class_name: 'Order', foreign_key: :receiving_user_id

  SIGNUP_BONUS_USER_ID              = -1
  LOGIN_BONUS_USER_ID               = -2
  FRIEND_INTRODUCTION_BONUS_USER_ID = -3

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end

  def signup_bonus
    Order.create(payment_user_id: SIGNUP_BONUS_USER_ID, receiving_user_id: id, amount: 100)
  end

  def introduction_bonus
    Order.create(payment_user_id: FRIEND_INTRODUCTION_BONUS_USER_ID, receiving_user_id: id, amount: 50)
  end

  def grant_login_bonus
    if Order.where(payment_user_id: LOGIN_BONUS_USER_ID, receiving_user_id: id, created_at: Date.today.all_day).blank?
      Order.create(payment_user_id: LOGIN_BONUS_USER_ID, receiving_user_id: id, amount: 1)
    end
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
