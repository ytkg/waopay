class HomeController < ApplicationController
  before_action :grant_login_bonus, only: [:show]

  def index
  end

  def show
    @orders = @current_user.orders.order(id: :desc)
  end

  def qrcode
    @amount = qrcode_params['amount'].to_i
    unpack_str = "#{@amount}->#{current_user.id}".unpack('H*').first
    @qrcode_text = "wao://#{unpack_str}"
  end

  def grant_login_bonus
    @current_user.grant_login_bonus
  end

  private

  def qrcode_params
    params.require(:qrcode).permit(:amount)
  end
end
