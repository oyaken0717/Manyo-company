class LabelsController < ApplicationController
  
  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to admin_users_path, notice: "ラベルを作成しました。"
    else
      render "new", notice: "作成できませんでした。"
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to admin_users_path, notice: "ラベルを削除しました。"
  end
  private

  def label_params
    params.require(:label).permit(:name)
  end
end
