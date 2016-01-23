class PasswordResetsController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def find_user
    @user = User.find_by!(password_reset_token: (params[:id]))
  end

  def new
  end

  def edit
  end

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset
    redirect_to root_url, notice: 'Email sent'
  end

  def update
    if @user.password_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, notice: "Password expired"
    elsif @user.update_attributes(user_params)
      redirect_to root_url, notice: "Password has been reset"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation, :email)
  end
end
