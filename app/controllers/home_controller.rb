class HomeController < ApplicationController
  before_action :grant_login_bonus, only: [:show]

  def index
  end

  def show
    @orders = Order
              .includes(:receiving_user, :payment_user)
              .by_user_id(current_user.id)
              .order(id: :desc)
  end

  def qrcode
    @amount = qrcode_params['amount'].to_i
    @qrcode_text = WaopayCode.encode(@amount, current_user.id)
  end

  def grant_login_bonus
    current_user.grant_login_bonus
  end

  private

  def qrcode_params
    params.require(:qrcode).permit(:amount)
  end
end
