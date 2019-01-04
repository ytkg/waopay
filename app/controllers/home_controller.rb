class HomeController < ApplicationController
  def index
  end

  def show
    @orders = @current_user.orders.order(id: :desc)
  end
end
