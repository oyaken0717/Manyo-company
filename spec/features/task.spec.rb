require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  scenario "タスク一覧のテスト" do
    # visit new_session_path
    # fill_in "session_email", with: "a@a.com"
    # fill_in "session_password", with: "a@a.com"
    # click_button 'ログイン'
    # expect(page).to have_content 'ログインしました'
    visit tasks_path
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in "task_title", with:"test_task_01"
    fill_in "task_content", with:"testtesttest1"
    click_on "Create Task"
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest1'
  end

  scenario "タスク詳細のテスト" do
    visit tasks_path
    page.first(".task-index__show-link").click
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル３'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント３'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    expect(Task.order("created_at DESC").map(&:id)).to eq [12,11,10]
  end

  scenario "タスクが終了期限の昇順に並んでいるかのテスト" do
    visit tasks_path
    click_link "終了期限でソートする"
    @tasks = Task.order("deadline ASC")
    expect(@tasks[0].deadline < @tasks[1].deadline).to be true
  end

  scenario "タスクが優先順位の降順に並んでいるかのテスト" do
    visit tasks_path
    click_on "優先順位でソートする"
    expect(Task.order("priority DESC").map(&:priority)).to eq ["高","中","低"]
  end
end
