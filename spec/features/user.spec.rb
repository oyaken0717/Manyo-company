require "rails_helper"

RSpec.feature "ユーザー管理機能", type: :feature do
  background do
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
  end

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

  scenario "ログインのテスト" do
    visit new_session_path
    fill_in "session_email", with: "a@a.com"
    fill_in "session_password", with: "a@a.com"
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
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
end
