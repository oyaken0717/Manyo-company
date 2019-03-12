require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  scenario "タスク一覧のテスト" do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
  Task.create!(name: 'test_task_01', content: 'iiiiiiiiiiii')
  Task.create!(name: 'test_task_02', content: 'dddddddddddd')

  # tasks_pathにvisitする（タスク一覧ページに遷移する）
  visit tasks_path

  # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
  # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
  expect(page).to have_content 'iiiiiiiiiiii'
  expect(page).to have_content 'dddddddddddd'

  end

  scenario "タスク作成のテスト" do

  end

  scenario "タスク詳細のテスト" do

  end
end
