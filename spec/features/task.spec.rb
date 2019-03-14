require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  scenario "タスク一覧のテスト" do

    Task.create!(name: 'test_task_01', content: 'iiiiiiiiiiii')
    Task.create!(name: 'test_task_02', content: 'dddddddddddd')

    visit tasks_path

    expect(page).to have_content 'iiiiiiiiiiii'
    expect(page).to have_content 'dddddddddddd'

  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in "task_name", with:"test_task_03"

    fill_in "task_content", with:"testtesttest3"
    click_on "Create Task"
    expect(page).to have_content 'test_task_03'
    expect(page).to have_content 'testtesttest3'
  end

  scenario "タスク詳細のテスト" do
    Task.create!(name: 'test_task_01', content: 'iiiiiiiiiiii')
    visit tasks_path
    click_on "詳細"
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'iiiiiiiiiiii'


  end
end
