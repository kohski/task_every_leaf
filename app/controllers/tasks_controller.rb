class TasksController < ApplicationController
  before_action :set_task,only:[:edit,:update,:show,:destroy]
  before_action :set_status,only:[:show,:index]
  before_action :logg_in_check

  def index
    if params.has_key?(:task) && params[:task][:search] == "true" 
      @name = params[:task][:name]
      @status = params[:task][:status]
      @label = params[:task][:label] unless params[:task][:label] == "未選択"
      @tasks = Task.where(user_id: current_user.id).search(@name, @status).where(id: shaping_label_request(@label)).page(params[:page]).per(10)
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
      build_labeling      
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path,notice:"タスクを編集しました"
      build_labeling
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
    req = params.require(:task).permit(:name,:content,:'expired_at(1i)',:'expired_at(2i)',:'expired_at(3i)',:'expired_at(4i)',:'expired_at(5i)',:status,:priority,:label_ids)
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

  def build_labeling
    @task.labelings.destroy_all
    label_ids = params[:task][:label_ids]
    if label_ids && label_ids.size > 0
      label_ids.each do |id|
        @task.labelings.create(label_id:id)
      end
    end
  end

  def shaping_label_request(label_name)
    if Label.where(name: @label).size > 0
      @label_id = current_user.labels.where(name: @label)[0].id 
      @task_ids_from_labelings = Labeling.where(label_id: @label_id).pluck(:task_id)
    else
      Task.all.pluck(:id)
    end
  end

end
