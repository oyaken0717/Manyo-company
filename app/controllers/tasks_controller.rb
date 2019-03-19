class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)

    if params[:task].present?
      @tasks = Task.search_title(params[:task][:title])
      if params[:task][:status].present?
        @tasks = @tasks.search_status(params[:task][:status])
      end
    end
    @tasks = Task.all.order(deadline: :asc) if params[:deadline] == "true"
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
      @task = Task.new(task_params)
      if @task.save
        redirect_to tasks_path, notice: "作成しました！！"
      else
        render "new"
      end
  end

  def show
  end

  def edit
  end

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
    @task = Task.new(task_params)
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
