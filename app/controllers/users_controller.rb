class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def new
    redirect_to mypage_path if signed_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.signup_bonus
      redirect_to login_path
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end
end
