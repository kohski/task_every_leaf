class TasksController < ApplicationController
  before_action :set_task,only:[:edit,:update,:show,:destroy]
  before_action :set_status,only:[:show,:index]
  before_action :logg_in_check

  def index
    if params.has_key?(:task) && params[:task][:search] == "true" 
      @name = params[:task][:name]
      @status = params[:task][:status]
      @tasks = Task.where(user_id: current_user.id).search(@name, @status).page(params[:page]).per(10)
    elsif params[:sort_expired]
      @tasks = Task.where(user_id: current_user.id).order(:expired_at).page(params[:page]).per(10)
    elsif params[:sort_priority]
      @tasks = Task.where(user_id: current_user.id).order(priority: :desc).page(params[:page]).per(10)
    else
      @tasks = Task.where(user_id: current_user.id).order(:created_at).page(params[:page]).per(10)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path,notice: "タスクを登録しました"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path,notice:"タスクを編集しました"
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path,notice: "タスクを消去しました"
  end

  private

  def task_params
    req = params.require(:task).permit(:name,:content,:'expired_at(1i)',:'expired_at(2i)',:'expired_at(3i)',:'expired_at(4i)',:'expired_at(5i)',:status,:priority)
    name = req[:name]
    content = req[:content]
    year = req[:'expired_at(1i)'].to_i
    month = req[:'expired_at(2i)'].to_i
    day = req[:'expired_at(3i)'].to_i
    hour = req[:'expired_at(4i)'].to_i
    minutes = req[:'expired_at(5i)'].to_i
    expired = DateTime.new(year,month,day,hour,minutes)
    status = req[:status].to_i
    priority = req[:priority]
    { name: name, content: content,expired_at: expired,status: status, priority: priority }
  end

  def set_task
    begin
      @task = Task.find(params[:id])
    rescue
      redirect_to tasks_path, notice: "無効な入力です。"
    end
  end

  def set_status
    @status_set = ["未着手","着手","完成"]
  end

  def logg_in_check
    unless logged_in?
      redirect_to new_session_path,notice: "ログインまたはサインアップしてください"
    end
  end

end
