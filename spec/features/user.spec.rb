require "rails_helper"

RSpec.feature "ユーザー管理機能", type: :feature do
  # background do
  #   FactoryBot.create(:user)
  #   FactoryBot.create(:second_user)
  # end

  scenario "ユーザー登録のテスト" do
    visit new_user_path
    fill_in "user_name", with: "b@b.com1"
    fill_in "user_email", with: "b@b.com"
    fill_in "user_password", with: "b@b.com2"
    fill_in "user_password_confirmation", with: "b@b.com2"
    click_on "アカウント登録"
    expect(page).to have_content 'b@b.com1'
    expect(page).to have_content 'b@b.com'
  end

  scenario "ログイン成功のテスト" do
    visit new_session_path
    fill_in "session_email", with: "a@a.com"
    fill_in "session_password", with: "a@a.com"
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  scenario "ログイン失敗のテスト" do
    visit new_session_path
    fill_in "session_email", with: ""
    fill_in "session_password", with: "a@a.com"
    click_button 'ログイン'
    expect(page).to have_content "ログインに失敗しました"
  end

  scenario "ログアウトのテスト" do
    visit new_session_path
    fill_in "session_email", with: "a@a.com"
    fill_in "session_password", with: "a@a.com"
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました'
  end

  scenario "ログイン時「ログイン」ページに行かない" do
    visit new_session_path
    fill_in "session_email", with: "a@a.com"
    fill_in "session_password", with: "a@a.com"
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
    click_on "プロフィール"
    expect(page).to have_content "メールアドレス"
  end

  scenario "ログアウト時「仕事」ページに行かない" do
    visit tasks_path
    expect(page).to have_content 'ログインしてください'
  end

  scenario "自分が作成したタスクだけを表示するかテストした" do
    visit new_session_path
    fill_in "session_email", with: "a@a.com"
    fill_in "session_password", with: "a@a.com"
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'

    visit new_task_path
    fill_in 'task_title', with: 'a@a.com'
    fill_in 'task_content', with: 'a@a.com'
    fill_in 'task_deadline', with: "2019-03-1"
    select '未着手', from: 'task_status'
    select '低', from: 'task_priority'
    click_on 'Create Task'
    click_link 'ログアウト'

    visit new_session_path
    fill_in "session_email", with: "c@c.com"
    fill_in "session_password", with: "c@c.com"
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'

    visit new_task_path
    fill_in 'task_title', with: 'c@c.com'
    fill_in 'task_content', with: 'c@c.com'
    fill_in 'task_deadline', with: "2019-03-1"
    select '未着手', from: 'task_status'
    select '低', from: 'task_priority'
    click_on 'Create Task'
    expect(page).to have_content 'c@c.com'
    expect(page).not_to have_content 'a@a.com'
  end
end
