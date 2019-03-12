class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    Blog.create(title: params[:blog][:title], content: params[:blog][:content])
    @task = Task.create(task_params)
    redirect_to new_task_path
  end

  privete

  def task_params
    params.require(:task).permit(:name, :deadline, :priority, :status, :label)
  end


end
