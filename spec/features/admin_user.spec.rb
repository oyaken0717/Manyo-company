require "rails_helper"
RSpec.feature "管理ユーザー機能", type: :feature do

  background do
    FactoryBot.create(:admin_user)
    visit new_session_path
    fill_in 'session_email', with: 'ad@ad.com'
    fill_in 'session_password', with: 'ad@ad.com'
    click_button 'ログイン'
  end

  scenario "タスク一覧のテスト" do
    visit admin_users_path
    expect(page).to have_content 'ad@ad.com'
  end
end
