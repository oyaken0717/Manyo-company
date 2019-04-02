require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  let!(:task_a) { FactoryBot.create(:task) }

  FactoryBot.create(:label)
  
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  before do
    visit new_session_path
    fill_in 'session_email', with: 'a@a.com'
    fill_in 'session_password', with: 'a@a.com'
    click_button 'ログイン'
  end

  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content 'タイトル1'
    expect(page).to have_content 'コンテンツ1'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in "task_title", with:"タイトルnew"
    fill_in "task_content", with:"コンテンツnew"
    fill_in "task_deadline", with: Date.today
    click_on "Create Task"
    expect(page).to have_content 'タイトルnew'
    expect(page).to have_content 'コンテンツnew'
  end

  scenario "タスク詳細のテスト" do
    visit tasks_path
    page.first(".task-index__show-link").click_link
    expect(page).to have_content 'タイトル3'
    expect(page).to have_content 'コンテンツ3'
  end

  scenario "タスク更新のテスト" do
    visit edit_task_path(task_a)
    fill_in "task_title", with:"タイトルupdate"
    fill_in "task_content", with:"コンテンツupdate"
    click_on "Update Task"
    expect(page).to have_content 'タイトルupdate'
    expect(page).to have_content 'コンテンツupdate'
  end

  scenario "タスク削除のテスト" do
    visit tasks_path
    page.first(".delete_num").click_link
    expect(page).to have_content '削除しました！！'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    expect(Task.order("created_at DESC").map(&:id)).to eq [24,23,22,21]
  end

  scenario "タスクが終了期限の昇順に並んでいるかのテスト" do
    visit tasks_path
    click_link "終了期限でソートする"
    @tasks = Task.order("deadline ASC")
    expect(@tasks[0].deadline < @tasks[1].deadline).to be false
  end

  scenario "タスクが優先順位の降順に並んでいるかのテスト" do
    visit tasks_path
    click_on "優先順位でソートする"
    expect(Task.order("priority DESC").map(&:priority)).to eq ["高","中","低","低"]
  end

  scenario "タスク作成(タグ付き)のテスト" do
    visit new_task_path
    fill_in "task_title", with:"タイトルnew"
    fill_in "task_content", with:"コンテンツnew"
    fill_in "task_deadline", with: Date.today
    check "task_label_ids_1"
    click_on "Create Task"
    expect(page).to have_content 'タイトルnew'
    expect(page).to have_content 'コンテンツnew'
    expect(page).to have_content 'label1'
  end
end
