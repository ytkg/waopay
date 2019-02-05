class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to root_path
  end

  private
  def order_params
    params.require(:order).permit(:payment_user_id, :receiving_user_id, :amount)
  end
end
