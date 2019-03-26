require "rails_helper"
RSpec.feature "管理ユーザー機能", type: :feature do

  background do
    FactoryBot.create(:admin_user)
    visit new_session_path
    fill_in 'session_email', with: 'ad@ad.com'
    fill_in 'session_password', with: 'ad@ad.com'
    click_button 'ログイン'
  end

  scenario "ユーザーの一覧テスト" do
    visit admin_users_path
    expect(page).to have_content 'ad@ad.com'
  end

  scenario "ユーザー登録のテスト" do
    visit new_admin_user_path
    fill_in "user_name", with: "e@e.com"
    fill_in "user_email", with: "e@e.com"
    check 'user_admin'
    fill_in "user_password", with: "e@e.com"
    fill_in "user_password_confirmation", with: "e@e.com"
    click_on "アカウント登録"
    expect(page).to have_content 'e@e.com'
  end

  scenario "ユーザー詳細のテスト" do
    visit new_task_path
    fill_in "task_title", with:"タイトル5"
    fill_in "task_content", with:"コンテンツ5"
    fill_in "task_deadline", with:Date.today
    click_on "Create Task"
    click_on "登録する"
    visit admin_users_path
    click_on(class: 'admin_user_show')
    expect(page).to have_content 'タイトル5'
    expect(page).to have_content 'コンテンツ5'
  end

  scenario "ユーザー更新のテスト" do
    visit admin_users_path
    click_on(class: 'admin_user_edit')
    fill_in 'user_name', with: 'ad2@ad2.com'
    fill_in 'user_email', with: 'ad2@ad2.com'
    fill_in 'user_password', with: 'ad@ad.com'
    fill_in 'user_password_confirmation', with: 'ad@ad.com'
    click_on "アカウント登録"
    expect(page).to have_content 'ad2@ad2.com'
  end

  scenario "ユーザー更新のテスト" do
    visit admin_users_path
    click_on(class: 'admin_user_edit')
    fill_in 'user_name', with: 'ad2@ad2.com'
    fill_in 'user_email', with: 'ad2@ad2.com'
    fill_in 'user_password', with: 'ad@ad.com'
    fill_in 'user_password_confirmation', with: 'ad@ad.com'
    click_on "アカウント登録"
    expect(page).to have_content 'ad2@ad2.com'
  end
end
