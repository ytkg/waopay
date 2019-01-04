class Order < ApplicationRecord
  has_one :receiving_user, class_name: 'User', primary_key: :receiving_user_id, foreign_key: :id
  has_one :payment_user, class_name: 'User', primary_key: :payment_user_id, foreign_key: :id

  scope :by_user_id, ->(user_id) { where(receiving_user_id: user_id).or(Order.where(payment_user_id: user_id)) }
end
