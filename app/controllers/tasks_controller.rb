class TasksController < ApplicationController
  before_action :authenticate_session_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  PER = 5
  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(PER)
    if params[:task]
      @tasks = @tasks.search_title(params[:task][:title]).search_status(params[:task][:status]) if params[:task][:status].present? && params[:task][:title].present?
      @tasks = @tasks.search_title(params[:task][:title])if params[:task][:title].present?
      @tasks = @tasks.search_status(params[:task][:status])if params[:task][:status].present?
      # @tasks = @tasks.search_label(params[:task][:label_id]) if params[:task][:label_id].present?
      @tasks = Label.find(params[:task][:label_id]).getTasks() if params[:task][:label_id].present?
      #                                             ↑modelsのlabel.rbにあります。
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
    params.require(:task).permit(:title, :deadline, :priority, :status, :content, :name, label_ids: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
# label_id = 13
# このLabelに紐づくTaskを探したい！！

# ちなみに、1対多なら
# @label = Label.find(13).include(:task)
# @label.tasks
#　で済んだ。


# 多対多
# ①
# @label = Label.find(label_id)
# ①ー②
# @tasks = @label.task_labels.map(&:task)
# ↓↑
# ①ー②のやさしい言い換え
# @tasks = @label.task_labels.map do |task_label|
  # ①ー③
  # task_label.task
  # ①ー③のやさしい言い換え（意味同じ）
  # Task.find(task_label.task_id)
# end


# ②(宮崎さんの最適解)
# @tasks = Label.find(label_id).getTasks()


# ③テキストが求めてたもの
# @task_labels =  TaskLabel.where(label_id: label_id)
# @tasks = @task_labels.task)
