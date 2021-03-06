class Order < ApplicationRecord
  after_commit :notice_slack

  validates :payment_user_id, presence: true
  validates :receiving_user_id, presence: true
  validates :amount, presence: true

  has_one :receiving_user, class_name: 'User', primary_key: :receiving_user_id, foreign_key: :id
  has_one :payment_user, class_name: 'User', primary_key: :payment_user_id, foreign_key: :id

  scope :by_user_id, ->(user_id) { where(receiving_user_id: user_id).or(Order.where(payment_user_id: user_id)) }

  private
  def notice_slack
    message  = '```'
    message += "payment_user:   #{payment_user.name}\n"
    message += "receiving_user: #{receiving_user.name}\n"
    message += "amount:         #{amount}円"
    message += '```'

    SlackApi.post_message(message)
  end
end
