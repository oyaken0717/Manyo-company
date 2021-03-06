class UsersController < ApplicationController
  before_action :authenticate_session_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login
    else
      render "new"
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  private

  def login
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = "ログイン失敗"
      render "new"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
