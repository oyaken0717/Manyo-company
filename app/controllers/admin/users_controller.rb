class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :check_last_admin, only: [:destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def index
    @users = User.select(:id, :name, :email, :admin)
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def check_last_admin
    @user = User.find(params[:id])
    if @user.admin? && User.where(admin: true).count == 1
      redirect_to admin_users_path, notice: "管理ユーザーは少なくとも1人必要です。"
    end
  end
end
