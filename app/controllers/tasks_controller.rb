class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.order(created_at: :desc)

    if params[:task]
      @tasks = @tasks.search_title(params[:task][:title]).search_status(params[:task][:status]) if params[:task][:status].present? && params[:task][:title].present?
      @tasks = @tasks.search_title(params[:task][:title])if params[:task][:title].present?
      @tasks = @tasks.search_status(params[:task][:status])if params[:task][:status].present?
    end

    @tasks = Task.order(deadline: :asc) if params[:deadline].present?
    @tasks = Task.order(priority: :desc) if params[:priority].present?
    # -----------
    # if search_params[:sort_priority] == t('tasks.priority_sort_desc')
    #   @tasks = @tasks.order(priority: :asc)
    # end
    # -----------
    # @tasks = current_user.tasks.sort_priority if params[:sort_priority] == "true"#優先順位
    # ----------
    # elsif params[:sort_priority]
    # @tasks = current_user.tasks.sort_priority
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
