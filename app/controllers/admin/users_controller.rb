require './app/exceptions/no_admin_error.rb'

class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show,:edit,:update,:destroy]
  before_action :log_in_check
  before_action :admin_check

  def index
    @users = User.all.includes(:tasks).order(:created_at)
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_user_path(@user.id), notice: "登録しました"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @user.commit_action = params[:commit]
    if @user.update(user_params)
      if @user.is_abort_by_admin
        redirect_to admin_users_path,notice: "管理者は最低一人必要です。中止しました。"
      else
        if params[:commit] == "解除" || params[:commit] == "付与"
          redirect_to admin_users_path,notice: "編集しました"
        else
          redirect_to admin_user_path(@user.id),notice: "編集しました"
        end
      end
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:is_admin)
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def connect_log_in_params
    params.require(:user).permit(:email,:password)  
  end

  def log_in_check
    unless logged_in?
      redirect_to new_session_path, notice: "ログインかサインアップをしてください"
    end
  end

  def admin_check
  is_admin = current_user.is_admin
    begin
      unless is_admin
        raise NoAdminError
      end
    rescue => exception
      puts exception
      render file: Rails.root.join('public/no_admin.html'), status: 401, layout: false, content_type: 'text/html'

    end
  end
end
