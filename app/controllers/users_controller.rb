class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def new
    redirect_to mypage_path if signed_in?
    @user = User.new
    @introduction_username = [params[:u]].pack('H*')
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.signup_bonus

      introduction_user = User.find_by(username: params[:introduction_username])
      if introduction_user
        introduction_user.introduction_bonus
        @user.introduction_bonus
      end

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
