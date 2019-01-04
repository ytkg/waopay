class HomeController < ApplicationController
  before_action :grant_login_bonus, only: [:show]

  def index
  end

  def show
    @orders = @current_user.orders.order(id: :desc)
  end

  def grant_login_bonus
    @current_user.grant_login_bonus
  end
end
