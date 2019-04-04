class UsersController < ApplicationController
  before_action :set_user, only: [:show,:edit,:update,:destroy]

  def new
    if logged_in?
      redirect_to tasks_path, notice: "ログアウトしてからサインアップしてください"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: "登録しました"
    else
      render 'new'
    end
  end

  def show
    if current_user.id == @user.id
      @user
    else
      redirect_to tasks_path, notice: "他のユーザーの詳細画面は閲覧できません"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id),notice: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password)
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def connect_log_in_params
    params.require(:user).permit(:email,:password)  
  end

end
