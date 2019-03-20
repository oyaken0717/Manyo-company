class TasksController < ApplicationController
  before_action :authenticate_session_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  PER = 5
  def index
    # if current_user
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(PER)
    # else
      # redirect_to new_session_path
    # end

    if params[:task]
      @tasks = @tasks.search_title(params[:task][:title]).search_status(params[:task][:status]) if params[:task][:status].present? && params[:task][:title].present?
      @tasks = @tasks.search_title(params[:task][:title])if params[:task][:title].present?
      @tasks = @tasks.search_status(params[:task][:status])if params[:task][:status].present?
    end

    @tasks = Task.order(deadline: :asc).page(params[:page]).per(PER) if params[:deadline].present?
    @tasks = Task.order(priority: :desc).page(params[:page]).per(PER) if params[:priority].present?
  end

  def new
    @task = Task.new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "作成しました！！"
    else
      render "new"
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました！！"
    else
      render "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"削除しました！！"
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private

  def task_params
    params.require(:task).permit(:title, :deadline, :priority, :status, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
