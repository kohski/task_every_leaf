class TasksController < ApplicationController
  before_action :set_task,only:[:edit,:update,:show,:destroy]
  before_action :set_status,only:[:show,:index]

  def index
    if params.has_key?(:task) && params[:task][:search] == "true" 
      @name = params[:task][:name]
      @status = params[:task][:status]
      @tasks = Task.search(@name, @status)
    else
      if params[:sort_expired]
        @tasks = Task.order(:expired_at)
      else
        @tasks = Task.order(:created_at)
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    req = params.require(:task).permit(:name,:content,:'expired_at(1i)',:'expired_at(2i)',:'expired_at(3i)',:'expired_at(4i)',:'expired_at(5i)',:status,:prioriry)
    name = req[:name]
    content = req[:content]
    year = req[:'expired_at(1i)'].to_i
    month = req[:'expired_at(2i)'].to_i
    day = req[:'expired_at(3i)'].to_i
    hour = req[:'expired_at(4i)'].to_i
    minutes = req[:'expired_at(5i)'].to_i
    expired = DateTime.new(year,month,day,hour,minutes)
    status = req[:status].to_i
    prioriry = req[:prioriry]
    { name: name, content: content,expired_at: expired,status: status, prioriry: prioriry }
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

end
