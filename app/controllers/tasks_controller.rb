class TasksController < ApplicationController
  before_action :set_task,only:[:edit,:update,:show,:destroy]

  def index
    @tasks = Task.all
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
    params.require(:task).permit(:name,:content)
  end

  def set_task
    begin
      @task = Task.find(params[:id])      
    rescue => exception
      redirect_to tasks_path,notice: "無効な入力です"
    end
  end

end
