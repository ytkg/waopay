class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_user, only: [:create]

  def new
    redirect_to mypage_path if signed_in?
  end

  def create
    if @user.authenticate(session_params[:password])
      sign_in(@user)
      redirect_to mypage_path
    else
      flash.now[:danger] = t('.flash.invalid_password')
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private
  def set_user
    @user = User.find_by!(name: session_params[:name])
  rescue
    flash.now[:danger] = t('.flash.invalid_name')
    render action: 'new'
  end

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
