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
end
