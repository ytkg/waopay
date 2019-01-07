class HomeController < ApplicationController
  skip_before_action :require_sign_in!, only: [:index]
  before_action :grant_login_bonus, only: [:show]

  def index
  end

  def show
    @orders = Order
              .includes(:receiving_user, :payment_user)
              .by_user_id(current_user.id)
              .order(id: :desc)

    @order = Order.new
  end

  def pay
    begin
      @amount, user_id = WaopayCode.decode(pay_params['qrcode_text'])
      @user = User.find(user_id)
      @error = '残高が足りません。' if current_user.total_amount < @amount
    rescue
      @error = 'QRコードを確認してください。'
    end
  end

  def qrcode
    @amount = qrcode_params['amount'].to_i
    @qrcode_text = WaopayCode.encode(@amount, current_user.id)
  end

  def grant_login_bonus
    current_user.grant_login_bonus
  end

  private

  def pay_params
    params.require(:pay).permit(:qrcode_text)
  end

  def qrcode_params
    params.require(:qrcode).permit(:amount)
  end
end
