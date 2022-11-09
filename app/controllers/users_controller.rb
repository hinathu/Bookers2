class UsersController < ApplicationController

  before_action :set_user, only: ["show", "edit"]

  before_action :set_newbook, only: ["show", "index"]


  def show
    @books = Book.where(user_id: @user.id).page(params[:page])
  end

  def index
    @user = current_user
    @users = User.page(params[:page])
  end

  def edit
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  # ユーザー情報更新
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path
    else
      render :edit
    end
  end

  # 投稿データのストロングパラメータ
  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_newbook
    @newbook = Book.new
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end