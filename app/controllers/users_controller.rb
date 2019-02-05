class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def new
    redirect_to root_path if signed_in?
    @user = User.new
    cookies['signup_u'] = params[:u] if params[:u]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.signup_bonus

      introduction_user = User.find_by(name: [cookies['signup_u']].pack('H*'))
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
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
